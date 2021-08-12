# Android SDK
export CAPACITOR_ANDROID_STUDIO_PATH=/snap/bin/android-studio
export ANDROID_SDK_ROOT=$HOME/Android/Sdk

export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator

# Cargo
source "$HOME/.cargo/env"

# Executables
export PATH="$HOME/.local/bin:$PATH"

# Ruby Gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
