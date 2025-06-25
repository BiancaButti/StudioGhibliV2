#!/bin/bash

echo "🔧 Iniciando setup básico do projeto..."

# 1. Criar .gitignore para projetos iOS
echo "📝 Criando .gitignore..."
cat <<EOL > .gitignore
# Xcode
.DS_Store
build/
DerivedData/
*.xcuserstate
*.xcworkspace/xcuserdata
*.xcodeproj/xcuserdata

# SwiftPM
.build/
.swiftpm/xcode/package.xcworkspace/xcuserdata

# Fastlane
fastlane/report.xml
fastlane/Preview.html
fastlane/screenshots

# SwiftLint
.swiftlint.yml
EOL

# 2. Inicializar repositório Git
echo "📘 Inicializando Git..."
git init
git add .
git commit -m "Inicializa projeto com .gitignore"

# 3. Instalar SwiftLint (se não tiver)
echo "🔍 Verificando SwiftLint..."
if ! command -v swiftlint &> /dev/null
then
    echo "⬇️ Instalando SwiftLint via Homebrew..."
    brew install swiftlint
else
    echo "✅ SwiftLint já está instalado."
fi

# 4. Criar configuração básica do SwiftLint
echo "🛠️ Criando .swiftlint.yml..."
cat <<EOL > .swiftlint.yml
disabled_rules:
  - trailing_whitespace
  - line_length

opt_in_rules:
  - unused_optional_binding
  - unused_import

excluded:
  - Carthage
  - Pods
  - fastlane
EOL

# 5. Inicializar Fastlane (modo silencioso)
echo "🚀 Inicializando Fastlane..."
mkdir -p fastlane
cd fastlane
fastlane init --non-interactive --platform ios
cd ..

echo "✅ Setup básico concluído com sucesso!"
