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

## 📸 Capturas de Tela

| Tela Inicial | Configurações | Notificações | 
|--------------|---------------|
| ![Home](./assets/home.png) | ![Settings](./assets/settings.png) | ![Notificações](./assets/notifications.png) |
---

## 🛠 Instalação

git clone [https://github.com/SEU_USUARIO/hydration_reminder_app.git](https://github.com/Edv-Fendi/hidratationApp.git)
cd hydration_reminder_app
flutter pub get
flutter run 
