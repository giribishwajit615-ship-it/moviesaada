# web.py
from flask import Flask
import threading
import os
import time
import traceback

app = Flask(__name__)

@app.route("/")
def home():
    return "OK"

def run_bot():
    try:
        # Agar Script.py jab import ho to bot start hota hai, bas import karo:
        import Script
        # Agar Script has a function like main() to start, replace above with:
        # from Script import main
        # main()
    except Exception:
        traceback.print_exc()

if __name__ == "__main__":
    t = threading.Thread(target=run_bot, daemon=True)
    t.start()
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
