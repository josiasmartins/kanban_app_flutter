#!/bin/bash

# Função para extrair os três números da versão do arquivo pubspec.yaml
get_version() {
    # Verifica se o arquivo pubspec.yaml existe
    if [ -f "pubspec.yaml" ]; then
        # Usa o comando 'grep' para encontrar a linha que contém 'version'
        # Usa 'cut' para extrair os três números da versão
        version=$(grep "version:" pubspec.yaml | cut -d " " -f 2 | tr -d '"' | cut -d '+' -f 1)
        echo "$version"
    else
        echo "Arquivo pubspec.yaml não encontrado."
    fi
}

# Chamando a função e armazenando o resultado em uma variável
version=$(get_version)

# Imprime os três números da versão
echo "A versão do aplicativo de notas é: $version"


# Função para incrementar a versão
increment_version() {
    # Chamando a função get_version para obter a versão atual
    current_version=$(get_version)
    
    # Separando os três números da versão
    major=$(echo "$current_version" | cut -d '.' -f 1)
    minor=$(echo "$current_version" | cut -d '.' -f 2)
    patch=$(echo "$current_version" | cut -d '.' -f 3)
    
    # Incrementando a parte de patch
    ((patch++))
    
    # Construindo a nova versão
    new_version="$major.$minor.$patch"
    
    # Atualizando o arquivo pubspec.yaml com a nova versão
    sed -i "s/version: $current_version/version: $new_version/" pubspec.yaml
    
    # Imprimindo a nova versão
    echo "Versão atualizada para: $new_version"
}

# Chamando a função para incrementar a versão
increment_version

# Função para gerar o build do Flutter
build_flutter() {
    #flutter clean
    echo "Gerando o build do apk"
    flutter build apk --release

    #sleep 4 para o tempo

    echo "finalizado o build do apk"
}

# Função para mover o APK para a pasta 'apks'
move_apk() {
    rm -rf apks/*
    mkdir -p apks
    echo "Variavel $1"
    # mv build/app/outputs/flutter-apk/app-release.apk apks/notes_app_v$new_version.apk
    mv build/app/outputs/flutter-apk/app-release.apk apks/
    echo "Movido para a pasta apks"
    mv apks/app-release.apk apks/kanban_app$new_version.apk
    echo "Renomeado o apk para kanban_app$new_version.apk"
}

# # Função para alterar a versão do Flutter no pubspec.yaml
# change_flutter_version() {
#     sed -i '' "s/version: .*/version: $1/" pubspec.yaml
# }

# Função para gerar uma nova tag no Git
create_git_tag() {
    git add apks/.
    git add move_apk.sh
    git add pubspec.yaml
    git add README.md
    git status
    echo "adicionado na area de stage"
    git commit -m "Release version $new_version"
    echo "commitado com mensagem: Release version $new_version"
    git tag -a v$new_version -m "Version $new_version"
    echo "criado nova versão da tag: v$new_version"
    git push -u origin v$new_version
    echo "subido no repository a tag: v$new_version"
}

# Versão atual do app
current_version=$(grep "version:" pubspec.yaml | awk '{print $2}')

# Incrementar a versão (pode ser ajustado conforme suas necessidades)
# new_version=$((current_version + 1))

# Gera o build do Flutter
build_flutter

# Move o APK para a pasta 'apks'
move_apk $new_version

# Altera a versão do Flutter no pubspec.yaml
change_flutter_version $new_version


echo "Começando o update no readme"
bash update_readme.sh
echo "Terminado atualizacao no readme"

#Cria uma nova tag no Git
create_git_tag $new_version

echo "Build, versioning, and tagging completed successfully. $new_version"