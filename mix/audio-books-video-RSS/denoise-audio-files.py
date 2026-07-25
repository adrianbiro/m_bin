"""
for i in *.mp3; do ffmpeg -i "${i}" "${i//.mp3/.wav}"; done
pip install audio-denoiser soundfile
https://pypi.org/project/audio-denoiser/
needs NVDIA
"""

from pathlib import Path

from audio_denoiser.AudioDenoiser import AudioDenoiser


def clean_audio_file(*, in_file: str, out_file: str):
    denoiser = AudioDenoiser()
    print(f"Creating:\n\t{out_file}")
    denoiser.process_audio_file(in_file, out_file)


def main():
    FILES_LOCATION = (
        "/home/adrian/Downloads/zmaz/1980 Unfinished Tales of Numenor and Middle-earth"
    )
    out_files_location = f"{FILES_LOCATION}_CLEANED"

    out_loc = Path(out_files_location)
    out_loc.mkdir(parents=True, exist_ok=True)
    files = [f for f in Path(FILES_LOCATION).glob("*.wav") if f.is_file()]
    for i in files:
        of = out_loc.joinpath(i.name)
        clean_audio_file(in_file=str(i), out_file=str(of))
    print(f"Denoised files in:\n\t{out_files_location}")


if __name__ == "__main__":
    raise SystemExit(main())
    
