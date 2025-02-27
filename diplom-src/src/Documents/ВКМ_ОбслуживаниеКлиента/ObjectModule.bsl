
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий  

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
     	Возврат;
	КонецЕсли; 
	
	Если ЭтоНовый() Тогда 
		НовоеСообщение = Справочники.ВКМ_УведомленияТелеграмБоту.СоздатьЭлемент();
		ТекстСообщения = СтрШаблон("Создан документ Обслуживание клиента. Специалист %1. ДатаПроведенияРабот %2. Время начала работ %3. Время окончания работ %4 ", 
		Специалист, ДатаПроведенияРабот, Формат(ВремяНачалаРаботПлан, "ДЛФ=В"), Формат(ВремяОкончанияРаботПлан, "ДЛФ=В"));
		НовоеСообщение.ТекстСообщения = ТекстСообщения;
		НовоеСообщение.Записать();
	Иначе
		СтарыеРеквизиты = Новый Соответствие;
		СтарыеРеквизиты.Вставить("Специалист", Специалист);
		СтарыеРеквизиты.Вставить("ДатаРабот", ДатаПроведенияРабот);
		СтарыеРеквизиты.Вставить("ВремяНачала", Формат(ВремяНачалаРаботПлан, "ДЛФ=В"));
		СтарыеРеквизиты.Вставить("ВремяОкончания", Формат(ВремяОкончанияРаботПлан, "ДЛФ=В"));
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВКМ_ОбслуживаниеКлиента.Ссылка КАК Ссылка,
		|	ВКМ_ОбслуживаниеКлиента.Специалист КАК Специалист,
		|	ВКМ_ОбслуживаниеКлиента.ДатаПроведенияРабот КАК ДатаПроведенияРабот,
		|	ВКМ_ОбслуживаниеКлиента.ВремяНачалаРаботПлан КАК ВремяНачалаРаботПлан,
		|	ВКМ_ОбслуживаниеКлиента.ВремяОкончанияРаботПлан КАК ВремяОкончанияРаботПлан
		|ИЗ
		|	Документ.ВКМ_ОбслуживаниеКлиента КАК ВКМ_ОбслуживаниеКлиента
		|ГДЕ
		|	ВКМ_ОбслуживаниеКлиента.Ссылка = &Ссылка";
		
		Запрос.УстановитьПараметр("Ссылка", Ссылка);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		Выборка = РезультатЗапроса.Выбрать();
		
		НовыеРеквизиты = Новый Соответствие;
		Если Выборка.Следующий() Тогда 
			СсылкаДок = Выборка.Ссылка;
			НовыеРеквизиты.Вставить("Специалист", Выборка.Специалист);
			НовыеРеквизиты.Вставить("ДатаРабот", Выборка.ДатаПроведенияРабот);
			НовыеРеквизиты.Вставить("ВремяНачала", Формат(Выборка.ВремяНачалаРаботПлан, "ДЛФ=В"));
			НовыеРеквизиты.Вставить("ВремяОкончания", Формат(Выборка.ВремяОкончанияРаботПлан, "ДЛФ=В"));
		КонецЕсли;
		
		РезультатСравнения = ОбщегоНазначения.КоллекцииИдентичны(СтарыеРеквизиты, НовыеРеквизиты,,,Истина);	 
		
		Если Не РезультатСравнения Тогда 
			
			НовоеСообщение = Справочники.ВКМ_УведомленияТелеграмБоту.СоздатьЭлемент();
			
			МассивСообщений = Новый Массив; 
			НачалоСообщения = СтрШаблон("В документе %1 изменены реквизиты: ",СсылкаДок);  
			Для Каждого элСоответствия Из СтарыеРеквизиты Цикл
				Если элСоответствия.Значение <> НовыеРеквизиты[элСоответствия.Ключ]	Тогда
					ТекстСообщения = СтрШаблон("%1", элСоответствия.Ключ);
					МассивСообщений.Добавить(ТекстСообщения);
				КонецЕсли;		
				
			КонецЦикла;
			ТекстСообщенияПолный = НачалоСообщения + СтрСоединить(МассивСообщений, " ,");
			НовоеСообщение.ТекстСообщения = ТекстСообщенияПолный;
			НовоеСообщение.Записать();
				
		КонецЕсли; 
	Конецесли;	
КонецПроцедуры
	
Процедура ОбработкаПроведения(Отказ, РежимПроведения)  
	//Движения по регистру ВыполненныеКлиентуРаботы		
    Движения.ВКМ_ВыполненныеКлиентуРаботы.Записывать = Истина;  

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Клиент КАК Клиент,
		|	ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Договор КАК Договор,
		|	ЕСТЬNULL(ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Договор.ВКМ_СтоимостьЧасаРаботы, 0) КАК СтоимостьЧасаРаботы,
		|	СУММА(ЕСТЬNULL(ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.ЧасыКОплатеКлиенту, 0)) КАК КоличествоЧасов
		|ИЗ
		|	Документ.ВКМ_ОбслуживаниеКлиента.ВыполненныеРаботы КАК ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы
		|ГДЕ
		|	ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка = &Ссылка
		|	И &Дата МЕЖДУ ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Договор.ВКМ_ДатаНачалаДействияДоговора И ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Договор.ВКМ_ДатаОкончанияДействияДоговора
		|	И ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Договор.ВидДоговора = ЗНАЧЕНИЕ(Перечисление.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание)
		|
		|СГРУППИРОВАТЬ ПО
		|	ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Клиент,
		|	ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Договор,
		|	ЕСТЬNULL(ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Договор.ВКМ_СтоимостьЧасаРаботы, 0)";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Дата", Дата);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		ОбщегоНазначения.СообщитьПользователю("Для проведения документа необходимо заполнить табличную часть");
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать(); 	
	
	Пока Выборка.Следующий() Цикл   	
		Движение = Движения.ВКМ_ВыполненныеКлиентуРаботы.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Клиент = Клиент;
		Движение.Договор = Договор;
		Движение.КоличествоЧасов = Выборка.КоличествоЧасов;
		Движение.СуммаКОплате = Движение.КоличествоЧасов * Выборка.СтоимостьЧасаРаботы;
	КонецЦикла;
	
	//Движения по регистру ВыполненныеСотрудникомРаботы	
	Движения.ВКМ_ВыполненныеСотрудникомРаботы.Записывать = Истина; 
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Специалист КАК Сотрудник,
	|	СУММА(ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.ЧасыКОплатеКлиенту) КАК ЧасыКОплатеКлиенту,
	|	МАКСИМУМ(ЕСТЬNULL(ДоговорыКонтрагентов.ВКМ_СтоимостьЧасаРаботы, 0)) КАК СтоимостьЧасаРаботы,
	|	МАКСИМУМ(ВКМ_УсловияОплатыСотрудниковСрезПоследних.ПроцентОтРабот) КАК ПроцентОтРабот
	|ИЗ
	|	Документ.ВКМ_ОбслуживаниеКлиента.ВыполненныеРаботы КАК ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	|		ПО ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Клиент = ДоговорыКонтрагентов.Владелец
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ВКМ_УсловияОплатыСотрудников.СрезПоследних(
	|				&Дата,
	|				Сотрудник В
	|					(ВЫБРАТЬ
	|						ВКМ_ОбслуживаниеКлиента.Специалист КАК Специалист
	|					ИЗ
	|						Документ.ВКМ_ОбслуживаниеКлиента КАК ВКМ_ОбслуживаниеКлиента
	|					ГДЕ
	|						ВКМ_ОбслуживаниеКлиента.Ссылка = &Ссылка)) КАК ВКМ_УсловияОплатыСотрудниковСрезПоследних
	|		ПО ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Специалист = ВКМ_УсловияОплатыСотрудниковСрезПоследних.Сотрудник
	|ГДЕ
	|	ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка = &Ссылка
	|	И ДоговорыКонтрагентов.ВидДоговора = ЗНАЧЕНИЕ(Перечисление.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание)
	|
	|СГРУППИРОВАТЬ ПО
	|	ВКМ_ОбслуживаниеКлиентаВыполненныеРаботы.Ссылка.Специалист"; 
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Дата", НачалоМесяца(Дата));
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать(); 	
	
	Пока Выборка.Следующий() Цикл 
		Если Выборка.ПроцентОтРабот = Null Тогда  
			ОбщегоНазначения.СообщитьПользователю(СтрШаблон("Не задан процент от работ для специалиста %1", Выборка.Сотрудник));
			Отказ = Истина;
			Продолжить;
		КонецЕсли;	
		Движение = Движения.ВКМ_ВыполненныеСотрудникомРаботы.Добавить();
		Движение.Период = Дата;
		Движение.Сотрудник = Специалист;
		Движение.ЧасовКОплате = Выборка.ЧасыКОплатеКлиенту;
   		Движение.СуммаКОплате = Движение.ЧасовКОплате * Выборка.СтоимостьЧасаРаботы * Выборка.ПроцентОтРабот / 100;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
