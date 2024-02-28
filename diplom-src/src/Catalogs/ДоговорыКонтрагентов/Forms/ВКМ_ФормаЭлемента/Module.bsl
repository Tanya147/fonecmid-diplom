#Область ОписаниеПеременных

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПолеВвода = Элементы.ВидДоговора;
	ПолеВвода.УстановитьДействие("ПриИзменении", "ПолеВводаПриИзменении");
	
	ГруппаАбонентскоеОбслуживание = ДобавитьГруппуНаФорму("ГруппаАбонентскоеОбслуживание");
	
	ДобавляемыеРеквизиты = Новый Массив;
	НовыйРеквизит = Новый РеквизитФормы("ДатаНачалаДействияДоговора",Новый ОписаниеТипов("Дата",,,Новый КвалификаторыДаты(ЧастиДаты.Дата))); 
	ДобавляемыеРеквизиты.Добавить(НовыйРеквизит);
	
	НовыйРеквизит = Новый РеквизитФормы("ДатаОкончанияДействияДоговора",Новый ОписаниеТипов("Дата",,,Новый КвалификаторыДаты(ЧастиДаты.Дата))); 
	ДобавляемыеРеквизиты.Добавить(НовыйРеквизит);
	
	НовыйРеквизит = Новый РеквизитФормы("СуммаАбонентскойПлаты",Новый ОписаниеТипов("Число",Новый КвалификаторыЧисла(15,2, ДопустимыйЗнак.Неотрицательный))); 
	ДобавляемыеРеквизиты.Добавить(НовыйРеквизит);
	
	НовыйРеквизит = Новый РеквизитФормы("СтоимостьЧасаРаботы",Новый ОписаниеТипов("Число",Новый КвалификаторыЧисла(15,2, ДопустимыйЗнак.Неотрицательный))); 
	ДобавляемыеРеквизиты.Добавить(НовыйРеквизит);
	
	ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	НовыйЭлемент = Элементы.Добавить("ДатаНачалаДействияДоговора", Тип("ПолеФормы"), ГруппаАбонентскоеОбслуживание);
	НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПутьКДанным = "Объект.ВКМ_ДатаНачалаДействияДоговора";
	
	НовыйЭлемент = Элементы.Добавить("ДатаОкончанияДействияДоговора", Тип("ПолеФормы"), ГруппаАбонентскоеОбслуживание);
	НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПутьКДанным = "Объект.ВКМ_ДатаОкончанияДействияДоговора";
	
	НовыйЭлемент = Элементы.Добавить("СуммаАбонентскойПлаты", Тип("ПолеФормы"), ГруппаАбонентскоеОбслуживание);
	НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПутьКДанным = "Объект.ВКМ_СуммаАбонентскойПлаты";
	
	НовыйЭлемент = Элементы.Добавить("СтоимостьЧасаРаботы", Тип("ПолеФормы"), ГруппаАбонентскоеОбслуживание);
	НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПутьКДанным = "Объект.ВКМ_СтоимостьЧасаРаботы";
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи) 
	Если Объект.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание Тогда
		
		Если ТекущийОбъект.ВКМ_ДатаНачалаДействияДоговора = Дата(1,1,1) Тогда
			ОбщегоНазначения.СообщитьПользователю("Заполните дату начала действия договора");
			Отказ = Истина;
		ИначеЕсли ТекущийОбъект.ВКМ_ДатаОкончанияДействияДоговора = Дата(1,1,1) Тогда
			ОбщегоНазначения.СообщитьПользователю("Заполните дату окончания действия договора");
			Отказ = Истина;
		ИначеЕсли ТекущийОбъект.ВКМ_СтоимостьЧасаРаботы = 0 Тогда	
			ОбщегоНазначения.СообщитьПользователю("Заполните стоимость часа работы");
			Отказ = Истина;
		ИначеЕсли ТекущийОбъект.ВКМ_СуммаАбонентскойПлаты = 0 Тогда	
			ОбщегоНазначения.СообщитьПользователю("Заполните сумму абонентской платы");	 
			Отказ = Истина;
		КонецЕсли;
	КонецЕсли;		
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	Если Объект.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание Тогда
		ДобавитьГруппуНаФорму("ГруппаАбонентскоеОбслуживание");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы //<ИмяТаблицыФормы>

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиКомандФормы

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПолеВводаПриИзменении(Элемент)
 
    Элементы.ГруппаАбонентскоеОбслуживание.Видимость = Объект.ВидДоговора = ПредопределенноеЗначение("Перечисление.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание");

КонецПроцедуры

&НаСервере
Функция ДобавитьГруппуНаФорму(ИмяЭлемента)
	
	Группа = Элементы.Найти(ИмяЭлемента);
	Если Группа<>Неопределено Тогда
		Группа.Видимость = Истина;
		Возврат Группа;
	КонецЕсли;
	
	ПолеВвода = Элементы.ВидДоговора;
	ПолеВвода.УстановитьДействие("ПриИзменении", "ПолеВводаПриИзменении");
	
	Группа = Элементы.Добавить(ИмяЭлемента, Тип("ГруппаФормы"));
	Группа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	Группа.Отображение = ОтображениеОбычнойГруппы.Нет;
	Группа.ОтображатьЗаголовок = ЛОЖЬ; 
	Группа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
	Элементы[ИмяЭлемента].Видимость = Ложь;
	Возврат Группа;
КонецФункции

 #КонецОбласти
