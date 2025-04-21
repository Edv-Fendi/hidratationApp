# 💧 Hydration Reminder App

Aplicativo Flutter para controle de hidratação com lembretes automáticos e meta diária personalizável.

---

## 📱 Funcionalidades

- Defina sua **meta diária de consumo de água (ml)**
- Registre o consumo com botões de **100ml, 200ml e 500ml**
- Acompanhe o progresso com barra de porcentagem colorida:
  - 🔴 até 25% — vermelho  
  - 🟡 até 60% — amarelo  
  - 🔵 até 99% — azul  
  - 🟢 100% — verde
- Configure lembretes para beber água em intervalos de:
  - 1 minuto (teste)
  - 2h, 4h, 6h, 8h, 12h
- Receba notificações com sua meta e quantidade consumida
- Armazenamento local com `shared_preferences`
- Notificações com `flutter_local_notifications`

---

## 🛠 Instalação

```bash
git clone https://github.com/Edv-Fendi/hidratationApp.git
cd hydration_reminder_app
flutter pub get
flutter run
```


### Pré-requisitos

1. Certifique-se de que o Flutter está instalado em sua máquina. Caso não esteja, siga as instruções de instalação no site oficial: [Flutter Installation](https://docs.flutter.dev/get-started/install).
2. Configure o ambiente Android (instale o Android Studio e configure o SDK).

### Passos para Gerar o APK

1. **Abra o terminal na raiz do projeto e utilize o comando**:

   ```bash
   cd hidratationApp
   ```

2. **Verifique se todas as dependências estão instaladas**:

   ```bash
   flutter pub get
   ```

3. **Para compilar o aplicativo para ANDROID**:
   Siga o comando abaixo para gerar o APK:

   ```bash
   flutter build apk --release
   ```

4. ** O APK será gerado no diretório:**:

   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

5. **Teste o APK**:
   Transfira o arquivo APK gerado para um dispositivo Android e instale-o para testar.

## 📸 Capturas de Tela

### 🏠 Tela Inicial (Home)
Visualize sua meta diária, consumo atual e adicione facilmente 100ml, 200ml ou 500ml de água.

<img src="https://raw.githubusercontent.com/Edv-Fendi/hidratationApp/main/lib/assets/home.png" width="300"/>

---

### ⚙️ Tela de Configurações
Defina sua meta diária e escolha o intervalo de lembretes para manter a hidratação em dia.

<img src="https://raw.githubusercontent.com/Edv-Fendi/hidratationApp/main/lib/assets/settings.png" width="300"/>

---

### 🔔 Exemplo de Notificação
Receba lembretes automáticos com base na sua meta e no quanto já foi ingerido.

<img src="https://raw.githubusercontent.com/Edv-Fendi/hidratationApp/main/lib/assets/notification.png" width="300"/>




