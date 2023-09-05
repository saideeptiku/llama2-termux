cd
# update packages
pkg update && pkg upgrade -y                                                                                 
# install necessary packages
pkg install clang wget git cmake -y
#cloning the github repository of llamma.cpp                                                                                                       
git clone https://github.com/ggerganov/llama.cpp.git
#enter llamma.cpp folder
cd llama.cpp                                                                                                                                      

# since this project uses an older GGML model format, we revert back to an older version
git checkout dadbed99e65252d79f81101a392d0d6497b86caa

#start building llamma.cpp (if you get an error try replqcing make with cmake and see if that works)
make

cd models

wget https://huggingface.co/TheBloke/Llama-2-7B-GGML/resolve/main/llama-2-7b.ggmlv3.q5_0.bin
# if using newer llama.cpp with GGUF file support. use the following:
wget https://huggingface.co/TheBloke/Llama-2-7B-GGUF/raw/main/llama-2-7b.Q4_0.gguf

cd

cat << EOF > chat_with_bob_7b.sh
#!/bin/bash

cd

cd llama.cpp

./main -m ./models/llama-2-7b.ggmlv3.q5_0.bin -n 512 -b 1016 -c 1016 --repeat_penalty 1.0 --color -i -r "User:" -f prompts/chat-with-bob.txt

EOF

chmod +x chat_with_bob_7b.sh

# making a shortcut script to launch alpaca easily with the word chat

cd /$PREFIX/bin
echo 'clear' > chat_with_bob_7b
echo 'cd' >> chat_with_bob_7b
echo './chat_with_bob_7b.sh' >> chat_with_bob_7b

chmod +x chat_with_bob_7b

cd
