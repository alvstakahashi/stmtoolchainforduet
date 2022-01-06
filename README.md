# stmtoolchainforduet
STM32 マイコン用　TOPPERS/ASP3 ビルド環境  arm64マシン用
STM32 マイコン用　TOPPERS/ASP3 ビルド環境です。<br>

arm64 linux で実行できるように　Lenovo chromebook Duetで作成しました。 <br>
https://hub.docker.com/r/alvstakahashi/stmtoolchainforduet  <br>

概要 <br>

できること <br>
1.TOPPERS/ASP3 のarm系のビルドができます。 <br>
STM32F401RE Nucleo-64（STマイクロ社） <br>
Cortex-A9（Zynq-7000） <br>
の2つはビルド確認済み <br>
2.QEMUで実行できます <br>
Cortex-A9（Zynq-7000） <br>
で確認済み <br>

3.Homebrewが使える <br>

できないこと <br>
TOPPPERS/ASPはビルドできません。 <br>
コンフィグレータの新しいものを使えばいいかと思いますが <br>
情報がつかめなかったため、未対応です。 <br>


利用環境 <br>
chromebook arm64機 <br>
Windows10 64bit DockerDesktop <br>

なのでおそらく <br>
chromebook x86_64機 <br>
M1　Mac <br>
Intel版Mac <br>
も動作するように思います。持ってないので検証してません。 <br>

利用方法 <br>

docker pull alvstakahashi/stmtoolchainforduet:1  <br>
docker run -it -rm alvstakahashi/stmtoolchainforduet:1 <br>

Intel機で実行するときは、--platform linux/arm64 のオプションをつければ <br>
警告がでなくなるようです。 <br>

tag説明<br>
1.0 最初のリリース<br>
1.1 cfg TOPPERSコンフィグレータを追加しました<br>
1.2 arm-none-eabi-gdb を追加しました<br>


以上 <br>
