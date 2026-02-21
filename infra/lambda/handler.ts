import {
    BedrockAgentRuntimeClient,
    InvokeAgentCommand
} from "@aws-sdk/client-bedrock-agent-runtime";

// Explicit region is REQUIRED for Bedrock Agent Runtime.
// Never rely on implicit region resolution inside Lambda.
const client = new BedrockAgentRuntimeClient({
    region: process.env.AWS_REGION || "us-east-1"
});

export const handler = async (event: any) => {
    console.log("=== Incoming Event ===");
    console.log(JSON.stringify(event, null, 2));

    const body =
        typeof event.body === "string"
            ? JSON.parse(event.body)
            : event.body || {};

    const inputText = body.input ?? "Hello, Mr. Beefy";

    const agentId = process.env.AGENT_ID;
    const aliasId = process.env.AGENT_ALIAS_ID;

    console.log("Agent ID:", agentId);
    console.log("Alias ID:", aliasId);
    console.log("Input text:", inputText);

    try {
        const command = new InvokeAgentCommand({
            agentId,
            agentAliasId: aliasId,
            sessionId: "web-" + Date.now().toString(),
            inputText
        });

        console.log("Sending InvokeAgentCommand:", {
            agentId,
            aliasId,
            inputText
        });

        const response = await client.send(command);

        console.log("Raw Bedrock response:", response);

        let text = "";
        if (response.completion) {
            for await (const chunk of response.completion) {
                if (chunk.chunk?.bytes) {
                    const decoded = new TextDecoder().decode(chunk.chunk.bytes);
                    console.log("Chunk:", decoded);
                    text += decoded;
                }
            }
        }

        console.log("Final assembled text:", text);

        return {
            statusCode: 200,
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ reply: text })
        };

    } catch (err: any) {
        console.error("=== ERROR invoking Bedrock Agent ===");
        console.error(err);

        return {
            statusCode: 500,
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                error: "Bedrock invocation failed",
                details: err.message || String(err)
            })
        };
    }
};