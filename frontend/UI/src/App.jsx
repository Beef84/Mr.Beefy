import { useState, useRef, useEffect } from "react";
import "./App.css";

function App() {
    const [messages, setMessages] = useState([]);
    const [input, setInput] = useState("");
    const inputRef = useRef(null);
    const API_URL = "/chat";

    async function sendMessage() {
        if (!input.trim()) return;

        const userMessage = { role: "user", text: input };
        setMessages((prev) => [...prev, userMessage]);

        setInput("");

        try {
            const res = await fetch(API_URL, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ input: userMessage.text })
            });

            const data = await res.json();

            const agentMessage = {
                role: "assistant",
                text: data.reply || "(No response)"
            };

            setMessages((prev) => [...prev, agentMessage]);
        } catch (err) {
            setMessages((prev) => [
                ...prev,
                { role: "assistant", text: "Error contacting Mr. Beefy backend." }
            ]);
        }
    }

    // Auto-resize textarea
    useEffect(() => {
        if (inputRef.current) {
            inputRef.current.style.height = "auto";
            inputRef.current.style.height = inputRef.current.scrollHeight + "px";
        }
    }, [input]);

    return (
        <div className="page">
            <div className="shell">
                <header className="hero">
                    <h1 className="hero-title">Mr. Beefy</h1>
                </header>

                <div className="content-card">
                    <h2 className="section-title">What Is Mr. Beefy?</h2>
                    <p className="section-text">
                        Mr. Beefy is a fully serverless AI agent designed as a hands-on demonstration
                        of my engineering philosophy. Every part of this project—from the infrastructure
                        to the automation to the runtime behavior—reflects how I design, build, and
                        operate real-world systems.
                    </p>

                    <p className="section-text">
                        Ask questions about me, Jordan Oberrath, my background, my work experience, my skills,
                        or about the architecture and design of this project. Mr. Beefy is here to provide
                        insights into who I am as an engineer and how I approach building complex systems.
                    </p>

                    <div className="chat-box">
                        <div className="messages">
                            {messages.map((m, i) => (
                                <div
                                    key={i}
                                    className={`message ${m.role === "user" ? "user" : "assistant"}`}
                                >
                                    {m.text}
                                </div>
                            ))}
                        </div>

                        <div className="input-row">
                            <textarea
                                ref={inputRef}
                                className="chat-input"
                                value={input}
                                placeholder="Ask Mr. Beefy something..."
                                onChange={(e) => setInput(e.target.value)}
                                onKeyDown={(e) => {
                                    // Enter without Shift → send
                                    if (e.key === "Enter" && !e.shiftKey) {
                                        e.preventDefault();
                                        sendMessage();
                                    }

                                    // Shift+Enter → newline
                                    if (e.key === "Enter" && e.shiftKey) {
                                        e.preventDefault();
                                        setInput((prev) => prev + "\n");
                                    }
                                }}
                                rows={1}
                            />
                            <button onClick={sendMessage}>Send</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default App;