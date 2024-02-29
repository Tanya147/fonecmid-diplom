﻿#language: ru

@tree

Функционал: <описание фичи>

Как <Роль> я хочу
<описание функционала> 
чтобы <бизнес-эффект>   

Контекст:
	Дано я подключаю профиль TestClient "Тест"

Сценарий: <описание сценария>
* Заполнение шапки документа Обслуживание клиентов
	Когда открылось окно 'Обслуживание клиентов'
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	Тогда открылось окно 'Обслуживание клиента (создание)'
	* Заполнение поля Организация
		И я нажимаю кнопку выбора у поля с именем "Организация"
		Тогда открылось окно 'Организации'
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Обслуживание клиента (создание) *'
	* Заполнение поля Клиент	
		И я нажимаю кнопку выбора у поля с именем "Клиент"
		Тогда открылось окно 'Контрагенты'
		И в таблице "Список" я перехожу к строке
				| 'Наименование' |
				| 'Береза ООО' |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Обслуживание клиента (создание) *'
	* Заполнение поля Договор	
		И я нажимаю кнопку выбора у поля с именем "Договор"
		Тогда открылось окно 'Договоры контрагентов'
		И в таблице "Список" я перехожу к строке
				| 'Наименование' |
				| '434' |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Обслуживание клиента (создание) *'
	* Заполнение поля Специалист	
		И я нажимаю кнопку выбора у поля с именем "Специалист"
		Тогда открылось окно 'Физические лица'
		И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование' |
			| '000000002' | 'Сидоров А.В.' |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Обслуживание клиента (создание) *'
	* Заполнение даты и времени проведения работ и проблемы		
		И в поле с именем 'ДатаПроведенияРабот' я ввожу текст '26.02.2024'
		И я перехожу к следующему реквизиту
		И в поле с именем 'ВремяНачалаРаботПлан' я ввожу текст ' 9:00:00'
		И я перехожу к следующему реквизиту
		И в поле с именем 'ВремяОкончанияРаботПлан' я ввожу текст '12:00:00'
		И в поле с именем 'ОписаниеПроблемы' я ввожу текст 'Не работает компьютер'
* Заполнение табличной части документа		
	И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
	И в таблице "ВыполненныеРаботы" я нажимаю кнопку выбора у реквизита с именем "ВыполненныеРаботыОписаниеРабот"
	Тогда открылось окно 'Работы по обслуживанию'
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	Тогда открылось окно 'Работы по обслуживанию (создание)'
	И в поле с именем 'Наименование' я ввожу текст 'Ремонт ПК'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
	И я жду закрытия окна 'Работы по обслуживанию (создание) *' в течение 20 секунд
	Тогда открылось окно 'Работы по обслуживанию'
	И в таблице "Список" я выбираю текущую строку
	Тогда открылось окно 'Обслуживание клиента (создание) *'
	И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
	И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
	И я жду закрытия окна 'Обслуживание клиента (создание) *' в течение 20 секунд
