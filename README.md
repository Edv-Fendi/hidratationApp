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



## 🛠 Instalação

```bash
git clone https://github.com/Edv-Fendi/hidratationApp.git
cd hydration_reminder_app
flutter pub get
flutter run
