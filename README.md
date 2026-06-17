# STM32F103 Keyboard Flasher — 一键烧录工具

基于 WebUSB API 的 STM32F103C8T6 键盘固件烧录工具，支持 **Maple 003** 和 **STM32 系统 DFU** 引导程序。

## 快速开始

### 1. 准备浏览器

必须使用 **Chrome 89+** 或 **Edge 89+**（需要 WebUSB 支持）。

### 2. 安装驱动

#### Windows
1. 进入 `drivers/windows/` 目录
2. 右键 `install-driver.bat` → **以管理员身份运行**
3. 脚本会自动下载 Zadig 并启动
4. 在 Zadig 中：Options → List All Devices → 选择 **Maple 003** → 选择 **WinUSB** → Install Driver

#### Linux
```bash
cd drivers/linux/
chmod +x install-udev.sh
./install-udev.sh
```
安装 udev 规则后，拔掉键盘重新插入即可。

#### macOS
一般免驱，无需额外配置。

### 3. 打开烧录页面

在 Chrome/Edge 中打开 `index.html`。

### 4. 连接设备 & 烧录

1. **按住 ESC 键**，插入键盘 USB → 键盘进入 DFU 模式
2. 点击页面上的 **🔌 连接设备**，在弹出窗口中选择 Maple 003
3. 点击文件选择器，选择 `.bin` 固件文件
4. 点击 **🔥 烧录**
5. 等待进度条走完，设备自动重启

## 技术细节

| 项目 | 参数 |
|---|---|
| 引导程序 | Maple 003 |
| VID/PID | 0x1EAF / 0x0003 |
| 烧录地址 | 0x08002000 |
| DFU 协议 | 自动检测（标准 DFU / DfuSe） |
| 传输块大小 | 自动协商 |

## 文件结构

```
stm32-keyboard-flasher/
├── index.html                      # 主页面，浏览器打开即用
├── README.md                       # 本文件
└── drivers/
    ├── windows/
    │   ├── install-driver.bat      # Windows 一键驱动安装脚本
    │   └── zadig.ini               # Zadig 预配置文件
    └── linux/
        ├── install-udev.sh         # Linux 一键 udev 安装脚本
        └── 99-maple003.rules       # udev 规则文件
```

## 常见问题

**Q: 连接设备时提示 "未找到 DFU 接口"？**
确认键盘已进入 DFU 模式：按住 ESC 再插 USB。成功进入 DFU 模式后键盘不会正常工作（无按键响应），这是正常的。

**Q: 烧录后键盘没反应？**
烧录完成后键盘会自动重启。如果仍无反应，重新插拔 USB（不需要按 ESC）即可。

**Q: Chrome 连接设备弹窗里没有 Maple 003？**
驱动未安装。请按上方步骤安装驱动。

**Q: Linux 下提示权限不足？**
运行 `drivers/linux/install-udev.sh` 安装 udev 规则，重新插拔设备即可。

## 参考

- [WebDFU](https://github.com/devanlai/webdfu) — 本项目的参考实现
- [dfu-util](http://dfu-util.sourceforge.net/) — 命令行 DFU 工具
- [libopencm3](https://github.com/libopencm3/libopencm3) — Maple 引导程序上游
