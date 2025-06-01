import sys
from chatterbox.tts import ChatterboxTTS
import torchaudio as ta
import torch
import argparse

# Force CPU to avoid MPS/complex dtype issues
device = "cpu"

def parse_args():
    parser = argparse.ArgumentParser(description="Chatterbox CLI TTS")
    parser.add_argument("text", type=str, help="Text to synthesize")
    parser.add_argument("--audio-prompt", type=str, default=None, help="Path to reference voice WAV file")
    return parser.parse_args()

args = parse_args()
text = args.text
prompt = args.audio_prompt

print(f"[tts.py] Using device: {device}")
model = ChatterboxTTS.from_pretrained(device=device)

if prompt:
    print(f"[tts.py] Using audio prompt: {prompt}")
    wav = model.generate(text, audio_prompt_path=prompt)
else:
    wav = model.generate(text)

ta.save("cli_output.wav", wav, model.sr)
print("[tts.py] Generated cli_output.wav") 
