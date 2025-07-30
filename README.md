<h1 align="center">
<br>
  <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--jvDLhx0b--/c_imagga_scale,f_auto,fl_progressive,h_420,q_auto,w_1000/https://dev-to-uploads.s3.amazonaws.com/i/cpcr5w0kgl6j94tss7n9.png" alt="rails logo" width=400">
  <br>
    <br>
  TÌM HIỂU RUBY VÀ RUBY ON RAILS 
  <br><br>
</h1>

## Giới thiệu

- Ngôn ngữ: Ruby v3
- Framework: Ruby On Rails v7
- Demo CRUD

---

## Tổng quan

* **[Cài đặt Ruby](#1-cài-đặt-ruby)**
* **[Cài đặt rails và tạo mới](#2-cài-đặt-rails-và-tạo-mới)**
* **[Chạy project trên](#3-chạy-project-trên)**
* **[Tài liệu tham khảo](#4-tài-liệu-tham-khảo)**
---

## 1. Cài đặt Ruby

 * 📌 [Download Ruby Installer cho window](https://rubyinstaller.org/)
 * 📌 [RVM](https://rvm.io/)
 * 📌 [Another](https://www.ruby-lang.org/en/documentation/installation/)

## 2. Cài đặt rails và tạo mới

 ```sh
  gem install rails
  rails new vote
  ```

## 3. Chạy project trên

```sh
  docker compose build --no-cache
  docker compose up -d
  docker exec -it ruby_vote bash
  bundle install
  rails assets:clobber
  rails assets:precompile
  apt update
  apt install libvips libvips-dev
  rails db:migrate
  rails db:seed
  ```

## 3. Cài đặt chạy cron để gửi mail khi kết thúc bình chọn
```sh
  docker compose build web
  docker exec -it ruby_vote service cron start
  docker exec -it ruby_vote rails db:migrate
  docker exec -it ruby_vote whenever --update-crontab --set environment=development #nếu production thì set lại environment tương ứng
  ```

## 4. Tài liệu tham khảo

### Document

 * 📜 [Ruby on Rails Guides (v7.1.2)](https://guides.rubyonrails.org/index.html)
 * 📜 [Ruby Programming Language](https://www.ruby-lang.org/vi/documentation/)

**[⬆ Lên đầu trang](#tổng-quan)**