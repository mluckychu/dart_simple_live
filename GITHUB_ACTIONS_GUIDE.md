# GitHub Actions 自动编译指南

## 📦 自动编译说明

本项目已配置GitHub Actions,每次推送到master分支时会自动编译Android TV APK。

## 🚀 如何触发自动编译

### 方式1: 推送代码(自动触发)
```bash
git add .
git commit -m "your commit message"
git push origin master
```

### 方式2: 手动触发
1. 访问你的GitHub仓库
2. 点击 `Actions` 标签
3. 选择 `Build Android TV APK` 工作流
4. 点击 `Run workflow` 按钮
5. 选择分支(默认master)并运行

## 📥 下载APK

### 从Artifact下载
1. 进入 `Actions` 页面
2. 点击最新的构建记录
3. 滚动到底部找到 `Artifacts` 部分
4. 下载 `simple-live-tv-apk` 或 `simple-live-tv-aab`

### 从Releases下载
如果是推送到master分支的提交,会自动创建Release:
1. 进入 `Releases` 页面
2. 找到最新版本(格式为 `v{build_number}`)
3. 下载 `app-release.apk` 或 `app-release.aab`

## 🔧 配置说明

### GitHub Actions工作流
- **文件位置**: `.github/workflows/build-tv-app.yml`
- **触发条件**:
  - 推送到master/main分支
  - 针对TV app的Pull Request
  - 手动触发

### 构建环境
- **操作系统**: Ubuntu Latest
- **Java版本**: Temurin 17
- **Flutter版本**: 3.41.4 (stable)

### 输出文件
- **APK**: `simple_live_tv_app/build/app/outputs/flutter-apk/app-release.apk`
- **AAB**: `simple_live_tv_app/build/app/outputs/bundle/release/app-release.aab`

## 📝 文件说明

### APK vs AAB
- **APK (Android Package Kit)**: 直接安装到Android设备
- **AAB (Android App Bundle)**: 上传到Google Play商店

## 🌐 本地网络问题解决方案

如果本地编译时遇到Google Maven仓库访问问题:
- 已配置阿里云Maven镜像在 `android/build.gradle.kts` 和 `android/settings.gradle.kts`
- 已在 `android/gradle.properties` 中配置SSL/TLS协议

## 📋 构建状态徽章

在你的仓库README中添加构建状态徽章:

```markdown
![Build Status](https://github.com/你的用户名/dart_simple_live/workflows/Build%20Android%20TV%20APK/badge.svg)
```

## ⚙️ 高级配置

### 修改Flutter版本
编辑 `.github/workflows/build-tv-app.yml`:
```yaml
- name: Setup Flutter
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.41.4'  # 修改这里
```

### 修改Java版本
```yaml
- name: Setup Java
  uses: actions/setup-java@v4
  with:
    distribution: 'temurin'
    java-version: '17'  # 修改这里
```

### 修改构建类型
在构建步骤中添加更多选项:
```yaml
- name: Build APK (Debug)
  run: |
    cd simple_live_tv_app
    flutter build apk --debug

- name: Build APK (Profile)
  run: |
    cd simple_live_tv_app
    flutter build apk --profile
```

## 🐛 常见问题

### Q: 构建失败怎么办?
A: 查看Actions页面的详细日志,检查具体的错误信息。

### Q: 如何只构建Debug版本?
A: 修改workflow文件中的构建命令,将 `--release` 改为 `--debug`。

### Q: 可以同时构建多个架构的APK吗?
A: 是的,添加 `--split-per-abi` 参数:
```bash
flutter build apk --release --split-per-abi
```

### Q: Artifact保留多久?
A: 当前配置保留30天,可在workflow文件中修改 `retention-days`。

## 📞 获取帮助

如果遇到问题:
1. 查看GitHub Actions运行日志
2. 检查Flutter官方文档: https://flutter.dev/docs/deployment/android
3. 查看GitHub Actions文档: https://docs.github.com/en/actions

## 🎉 开始使用

1. Fork此仓库到你的GitHub账号
2. 推送代码或手动触发工作流
3. 等待构建完成(通常5-10分钟)
4. 下载生成的APK文件
5. 安装到Android TV设备或模拟器测试
