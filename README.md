# BusinessCalendar
## I need to develop an application that performs the functions of a business calendar. 
### The application must add notes to the calendar and notify user when it needed. Application should realize API to simplify requests from foreign modules.The application provides the division of roles (head, slave). The head can be optionally assigned by the administrator. Head can add instructions to a slave Calendar. The application will be used by a small staff of employees (up to 10 users). The application will be used a notification system based on web sockets. The application has a graphical user interface. It is supposed to use nginx & unicorn like a server development tools.
* The following classes for the application:
 * User
 * Note
 * Some optional classes needed to correct work with used tools (for example class Ability for CanCanCan)
* While developing I am going to follow next steps:
 * Define entities and add them to the application as models
 * Generate database with defined entities
 * REST architecture development
 * Front-end application development
 * Learning and implementing web sockets to allow the server respond to the client without the client's request
 * Api development to facilitate access to the server-side Task Scheduler
 * 
---
* Тэкставае апісанне праекта работы
 * Проект разрабатывается с использованием фреймворка Ruby on Rails. В проекте используются следующие модели, необходимые для реализации основного функционала: User, Note. Допустимо создание других моделей, необходимых для реализации функционала. Для хранения проекта используется база данных PostgreSQL. Проект использует Ruby версии 2.3.1 и Rails 5.0. Для ролей Admin, Head и User используется CanCanCan. Для авторизации используется Device. Для верстки используется bootstrap. Для отправки уведомлений пользователю предполагается использованиие node.js.
 * Проект представляет собой веб-приложение. Пользователь переходит по адресу приложения и попадает на страницу авторизации. Все функции доступны только после авторизации. Авторизованный пользователь переадрессовывается на страницу заметок. Пользователь, выступающий в роли User, может добавлять, редактировать и удалять заметки исключительно для себя. Head имеет доступ так же к заметкам других пользователей и может добавлять заметки не только для себя, но и для других пользователей. Admin имеет доступ к заметкам всех пользователей и может добавлять, редактировать и удалять заметки любого пользователя. Заметка состоит из названия (title), содержимого (content) и времени, когда она должна напомнить о себе (appointment). Заметка появляется на странице в виде pop-up в момент времени, когда она должна напомнить о себе. Предполаается звуковое уведомление пользователя. Напоминание можно перенести на другое время, для чего пользователь должен указать новое время уведомления.
 * Заметки могут быть активными (те, которые еще не напомнили о себе, и те, которые были перенесены на будущее время) и неактивными (те, которые уже напомнили о себе и не были перенесены на другое время).
* Спіс пунктаў запіскі:
 * id
 * title
 * content
 * appointment
* Апісанне классаў у умл
 * ![Img](https://github.com/plufmua/BusinessCalendar/blob/master/models_rails.JPG)
* Апісанне функцыянальных частак у выглядзе схемы
 * ![Img](https://github.com/plufmua/BusinessCalendar/blob/master/Schema.jpg)
 * Dashboard отвечает за то, что увидит пользователь после авторизации. В этой части приложения содержатся ссылки на все доступные пользователю функции приложения. Например, для User будут отображены ссылки на заметки, которые должны напомнить о себе в ближайшее время (за определенный промежуток времени), ссылка на все заметки, созданные данным пользователем, а так же ссылка на добавление новой заметки.
 * Notes - все заметки, созданные когда-либо пользователем. Здесь находятся так же неактивные заметки (те, которые уже сработали для пользователя).
 * Expired - заметки пользователя, которые должны напомнить что-либо пользователю в ближайшее время. Здесь не отображаются заметки, которые напомнили о себе и не были перенесены на будущее время.
 * Users - все пользователи, зарегистрированные в системе. Только Admin может удалять пользователей из системы.
 * UserNotes - заметки других пользователей. Доступны для ролей Admin и Head. Перейдя по этому адресу с Dashboard, пользователь видит список всех пользователей и ссылки на заметки этих пользователей. Для Head доступна так же функция "Add note to another user", которая позволяет добавить заметку/задание в календарь к другому пользователю. 
 * Roles - роли каждого из пользователей системы. Доступны только для администратора. Администратор может назначать и удалять роли для других пользователей.
* Тэхнічныя эксперыменты
 * Sidekiq
 * unicorn + nginx 
 * Mina 
 * Tropo (https://github.com/tropo/reminders)
