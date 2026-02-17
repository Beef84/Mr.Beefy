import "./App.css";

function App() {
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
                        Ask questions about me, Jordan Oberrath, my background, my work experience, my skills, or about the architecture and design of this project. Mr. Beefy is here to provide insights into who I am as an engineer and how I approach building complex systems.
                    </p>

                    <div className="placeholder-box">
                        <h3 className="placeholder-title">Chat Interface Coming Soon</h3>
                        <p className="placeholder-text">
                            This is the only temporary section. Once the backend integration is complete,
                            this will become the live interface to the Bedrock Agent Runtime.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default App;