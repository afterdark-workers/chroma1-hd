#!/bin/sh
# Chroma1-HD — everything the worker image needs. The Dockerfile in your copy downloads this file
# from the original repo on every build, so fixes made there reach you with a rebuild.
set -eu

# file <dest> <url> <sha256>
file() {
  wget -q -O "$1" "$2"
  echo "$3  $1" | sha256sum -c - || { echo "ERROR: $1 changed upstream — wait for an update of the original repo, then rebuild" >&2; exit 1; }
}

# Comfy-Org/Chroma1-HD (Apache 2.0) (9.2 GB)
file /comfyui/models/diffusion_models/Chroma1-HD-fp8mixed.safetensors \
  "https://huggingface.co/Comfy-Org/Chroma1-HD/resolve/409cfff960d66598d4d0ff46cb932f53492cc6d9/split_files/diffusion_models/Chroma1-HD-fp8mixed.safetensors" \
  a2928ca6075f308f4d5e2182e2b96120fa8ad270ec6ea9b1b5c724c85c49a575

# comfyanonymous/flux_text_encoders (4.9 GB)
file /comfyui/models/text_encoders/t5xxl_fp8_e4m3fn.safetensors \
  "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/6af2a98e3f615bdfa612fbd85da93d1ed5f69ef5/t5xxl_fp8_e4m3fn.safetensors" \
  7d330da4816157540d6bb7838bf63a0f02f573fc48ca4d8de34bb0cbfd514f09

# Comfy-Org repack (FLUX VAE) (0.3 GB)
file /comfyui/models/vae/ae.safetensors \
  "https://huggingface.co/Comfy-Org/Lumina-Image-2/resolve/5b072540ef86570fecb8249c505f23d5bdeb88cd/split_files/vae/ae.safetensors" \
  afc8e28272cd15db3919bacdb6918ce9c1ed22e96cb12c4d5ed0fba823529e38
