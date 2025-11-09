# RPG-Builder

Sistema para criação de personagens RPG com atributos sorteados, cadastro, edição, poderes e inventário.

## Funcionalidades

- Cadastro e edição de personagens.
- Definição de nome, sobrenome, raça, classe, poderes, história e inventário.
- Atributos sorteados automaticamente (Força, Destreza, Constituição, Inteligência, Sabedoria, Carisma).
- Geração automática de personagem.

## Tecnologias utilizadas

- Flutter 3+
- Dart
- Firebase Firestore
- Provider
- Faker

### Instalação e uso

1. Clone este repositório:
```
git clone https://github.com/Shinymonke69/Flutter_RPG_Builder_Project.git
```
2. Instale as dependências:
- baixe o [Flutter](https://docs.flutter.dev/install/manual)
```
npm install
flutter pub get
npm install firebase
```
3. Configure o Firebase para Web:
- No seu navegador faça login no site do [Firebase](https://firebase.google.com/), logo após fazer login vá até [Firebase Console](https://console.firebase.google.com/) e crie um novo projeto do Firebase com nome de ***rpg-builder*** e siga os passos do Firebase.
- Depois de criar sua Firebase ma visão geral do projeto terá um engrenagem e nela terá a opção de configurar seu projeto ***Geral*** -> ***Adicionar Aplicativo*** -> ***web*** -> Nome do app ***rpg-builder*** -> site do Firebase hosting vinculado ***selecionar seu projeto***.
- Após realizar tudo isso no seu vsCode na pasta lib edite seu ***firebase_options.dart*** com as informações que estão no seu Firebase Web:
```
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
    static FirebaseOptions get currentPlatform {
        if (kIsWeb) {
            return FirebaseOptions(
                apiKey: "SUA_API_KEY",
                authDomain: "SEU_AUTH_DOMAIN",
                projectId: "SEU_PROJECT_ID",
                storageBucket: "SEU_BUCKET",
                messagingSenderId: "SEU_MESSAGING_SENDER_ID",
                appId: "SEU_APP_ID",
            );
        }
        switch (defaultTargetPlatform) {
            case TargetPlatform.android:
                return FirebaseOptions(
                apiKey: 'SUA API KEY',
                appId: 'SEU APP ID',
                messagingSenderId: 'SEU MESSAGE ID',
                projectId: 'SEU PROJECT ID',
                );
            case TargetPlatform.iOS:
                return FirebaseOptions(
                apiKey: 'SUA API KEY',
                appId: 'SEU APP ID',
                messagingSenderId: 'SEU MESSAGE ID',
                projectId: 'SEU PROJECT ID',
                );
            default: 
                return FirebaseOptions (
                apiKey: 'SUA API KEY',
                appId: 'SEU APP ID',
                messagingSenderId: 'SEU MESSAGE ID',
                projectId: 'SEU PROJECT ID',
            );
        }
    }
}
```
- No Firebase vai ter uma aba de ***Criação*** -> ***Authentication*** -> ***Vamos começar*** -> ***E-mail/senha*** -> ***E-mail/senha ativar*** e ***salvar***.
- Ainda no Firebase novamente ***Criação*** -> ***FireStore Database*** -> ***Criar banco de dados*** -> ***Standart*** -> ***Local southamerica-east1 (São Paulo)*** -> ***Avançar*** e ***Criar*** -> em ***Regras*** altere ***false*** para ***true***(Essas regras de segurança estarão definidas como públicas. Com essa configuração, qualquer pessoa pode roubar, modificar ou excluir informações do seu banco de dados, ***use somente para testes e uso pedagógicos***).
4. Rode seu projeto no cmd ou bash:
```
flutter run -d chrome
```

## Dependências externas de API

Este projeto utiliza a API pública [D&D 5e API](https://www.dnd5eapi.co) para buscar dados aleatórios de classes, raças e magias do sistema D&D.
1. Endpoints consumidos:
- GET https://www.dnd5eapi.co/api/classes/ — retorna a lista de classes disponíveis.
- GET https://www.dnd5eapi.co/api/races/ — retorna a lista de raças disponíveis.
- GET https://www.dnd5eapi.co/api/spells/ — retorna a lista de magias disponíveis.
- O consumo é feito diretamente pelo app Flutter usando o pacote http.
2. Exemplo de requisição:
```
final resp = await http.get(Uri.parse('https://www.dnd5eapi.co/api/classes/'));
```

## Como contribuir

- Faça um fork do projeto
- Crie uma branch nova feature/nomedafeature
- Envie um pull request descrevendo sua alteração

## Licença

Este projeto está licenciado sob a Licença MIT, veja mais detalhes no arquivo LICENSE.md.
