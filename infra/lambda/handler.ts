import {
    BedrockAgentRuntimeClient,
    InvokeAgentCommand
} from "@aws-sdk/client-bedrock-agent-runtime";

const client = new BedrockAgentRuntimeClient({});

export const handler = async (event: any) => {
    const body = typeof event.body === "string" ? JSON.parse(event.body) : event.body || {};
    const inputText = body.input ?? "Hello, Mr. Beefy";

    const command = new InvokeAgentCommand({
        agentId: process.env.AGENT_ID!,
        agentAliasId: process.env.AGENT_ALIAS_ID!,
        sessionId: "web-" + Date.now().toString(),
        inputText
    });

    const response = await client.send(command);

    let text = "";
    if (response.completion) {
        for await (const chunk of response.completion) {
            if (chunk.chunk?.bytes) {
                text += new TextDecoder().decode(chunk.chunk.bytes);
            }
        }
    }

    return {
        statusCode: 200,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ reply: text })
    };
};