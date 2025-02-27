
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	//{{Хохлова Т.В. Добавление команды Заполнить
	Команда = Команды.Добавить("Заполнить");
	Команда.Заголовок = "Заполнить";
	Команда.Действие = "КомандаЗаполнить";
	
	КнопкаФормы = Элементы.Добавить("КнопкаЗаполнить", Тип("КнопкаФормы"), Элементы.ФормаКоманднаяПанель);
	КнопкаФормы.ИмяКоманды = "Заполнить";
	КнопкаФормы.Вид = ВидКнопкиФормы.ОбычнаяКнопка; 
	КнопкаФормы.ПоложениеВКоманднойПанели = ПоложениеКнопкиВКоманднойПанели.ВКоманднойПанели;   
	//}}
КонецПроцедуры  

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДоговорНачалоВыбора1(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	 //{{Хохлова Т.В. 
	СтандартнаяОбработка = Ложь;
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Контрагент", Объект.Контрагент);
	ОткрытьФорму("Справочник.ДоговорыКонтрагентов.Форма.ВКМ_ФормаВыбора", ПараметрыФормы, Элементы.Договор);
	//}}
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество;
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

&НаСервере
Функция ПолучитьРеквизитыДоговора(Договор)	
	//{{Хохлова Т.В.  
	ВидДоговора = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Договор, "ВидДоговора");
    Возврат ВидДоговора;
	//}}	
КонецФункции

//@skip-check module-unused-method
&НаКлиенте	
Процедура КомандаЗаполнить(Команда)
	//{{Хохлова Т.В. 
	ВидДоговора = ПолучитьРеквизитыДоговора(Объект.Договор); 
	Если ВидДоговора <> ПредопределенноеЗначение("Перечисление.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание") Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю("Должен быть выбран вид договора Абонентское обслуживание"); 
		Возврат;
	КонецЕсли;  
	
	ЗадатьВопросПользователю();
КонецПроцедуры	


//@skip-check function-should-return-value
&НаКлиенте
Асинх Функция ЗадатьВопросПользователю()
	//{{Хохлова Т.В.
	Обещание = ВопросАсинх("Табличная часть будет очищена. Продолжить?", РежимДиалогаВопрос.ДаНет,, КодВозвратаДиалога.Да);
	Результат = Ждать Обещание;
	Если Результат = КодВозвратаДиалога.Да Тогда
		ВыполнитьАвтозаполнениеДокументаНаСервере();
	КонецЕсли;
	//}}
КонецФункции

&НаСервере
Процедура ВыполнитьАвтозаполнениеДокументаНаСервере()
	//{{Хохлова Т.В. 
	Объект.Товары.Очистить();
	Объект.Услуги.Очистить(); 
	ДокументОбъект = РеквизитФормыВЗначение("Объект");
    ДанныеЗаполнения = ДокументОбъект.ВыполнитьАвтозаполнение();  
	
	Для Каждого элДанные из ДанныеЗаполнения Цикл
		НоваяСтрока = Объект.Услуги.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, элДанные); 
		Модифицированность = Истина;
	КонецЦикла;
     //}}
 КонецПроцедуры
 
#КонецОбласти
 
//@skip-check module-structure-top-region
#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры

// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

