# Hướng dẫn cài đặt Proxy IPv6 trên Cloud Server của CloudFly
Để cài đặt Proxy theo range IPv6 tại CloudFly trên máy chủ CentOS 7.9 thì mình thực hiện các bước sau ạ:

## Bước 1. Cấu hình địa chỉ IPv6 vào máy chủ bằng lệnh:

echo "IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
IPV6ADDR=2001:df7:c600:6:f816:3eff:fe7a:7839/64
IPV6_DEFAULTGW=2001:df7:c600:6::1" >> /etc/sysconfig/network-scripts/ifcfg-eth0

service network restart

==> Lưu ý: Thay đổi IPV6ADDR và IPV6_DEFAULTGW theo đúng thông tin Public IPv6 Network của máy chủ trong Tab Networking. IPV6ADDR là Address IPv6 và IPV6_DEFAULTGW là Gateway

- Kiểm tra cấu hình IPv6 thành công bằng cách chạy lệnh: ping6 cloudfly.vn

Nếu ping trả về gói tin thì cấu hình IPv6 đã thành công và chuyển sang bước 2

## Bước 2. Cài đặt proxy vào máy chủ với Range /112 như sau

Trường hợp Proxy có Username và Password  khác nhau
curl -sO https://raw.githubusercontent.com/kieunhutrung1/3proxy/main/ipv6-with-port-password.sh && chmod +x ipv6-with-port-password.sh && bash ipv6-with-port-password.sh

Trường hợp Proxy có Username và Password giống nhau
curl -sO https://raw.githubusercontent.com/kieunhutrung1/3proxy/main/ipv6-with-port-some-username-password.sh && chmod +x ipv6-with-port-same-username-password.sh && bash ipv6-with-port-same-username-password.sh

  Trường hợp Proxy không có Username và Password
curl -sO https://raw.githubusercontent.com/kieunhutrung1/3proxy/main/ipv6-with-port-none-password.sh && chmod +x ipv6-with-port-none-password.sh && bash ipv6-with-port-none-password.sh
![image](https://github.com/user-attachments/assets/13a69a22-86c7-46d4-b969-e0c2666f2d6e)


## Bước 3: Lấy thông tin tài khoản

Lấy thông tin tài khoản tại đường dẫn /home/cloudfly. Mở file proxy.txt để lấy các thông tin đăng nhập.

Tải phần mềm winscp [tại đây](https://winscp.net/eng/download.php), nhập thông tin máy chủ vào và làm theo các bước như hình ảnh dưới đây :
![image](https://github.com/user-attachments/assets/829c1670-2853-4b22-a7c6-c016c4df8ee4)
Tiếp theo Click vào thư mục Home
![image](https://github.com/user-attachments/assets/d16de860-346a-438b-af90-62a8005c22d5)
![image](https://github.com/user-attachments/assets/f11c46fc-9aa4-463d-8887-b40434423dc3)
![image](https://github.com/user-attachments/assets/cd8fa6df-d486-496c-9371-762b0aaa8da4)
![image](https://github.com/user-attachments/assets/110b0642-e2b5-43f6-bade-912073818ec2)
![image](https://github.com/user-attachments/assets/9069946c-207f-412a-8b2f-421717bdb4ce)










