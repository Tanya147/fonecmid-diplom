#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

Функция ПолучитьДанныеИзРегистровМенеджер(Организация, Период) Экспорт
	//Получаем данные из регистра для заполнения шапки документа                                      	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВКМ_ВыполненныеКлиентуРаботыОстатки.Клиент КАК Клиент,
	|	ВКМ_ВыполненныеКлиентуРаботыОстатки.Договор КАК Договор
	|	//СУММА(ВКМ_ВыполненныеКлиентуРаботыОстатки.КоличествоЧасовОстаток) КАК Количество,
	|	//СУММА(ВКМ_ВыполненныеКлиентуРаботыОстатки.СуммаКОплатеОстаток) КАК Сумма
	|ИЗ
	|	РегистрНакопления.ВКМ_ВыполненныеКлиентуРаботы.Остатки(&Период, ) КАК ВКМ_ВыполненныеКлиентуРаботыОстатки
	|
	|СГРУППИРОВАТЬ ПО
	|	ВКМ_ВыполненныеКлиентуРаботыОстатки.Клиент,
	|	ВКМ_ВыполненныеКлиентуРаботыОстатки.Договор";
	
	Запрос.УстановитьПараметр("Период", Период.ДатаОкончания); 
   	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать(); 
	                                                        
	резМассив = Новый Массив; 
		
	Пока Выборка.Следующий() Цикл  
		Данные = Новый Структура;
		Данные.Вставить("Дата", Период.ДатаОкончания);
		Данные.Вставить("Организация", Организация);
		Данные.Вставить("Контрагент", Выборка.Клиент);
		Данные.Вставить("Договор", Выборка.Договор);  
		
		ДокументСсылка = СозданиеРеализации(Данные);
		
		Данные.Вставить("ДокументСсылка", ДокументСсылка);  
		
		резМассив.Добавить(Данные); 		
	КонецЦикла;
	
	Возврат резМассив;	
	
КонецФункции

//@skip-check module-structure-method-in-regions
//@skip-check module-structure-method-in-regions
Функция СозданиеРеализации(Парам) 
	//Создаем и проводим реализации
	ДокументОбъект = Документы.РеализацияТоваровУслуг.СоздатьДокумент(); 
	
	ДокументОбъект.Заполнить(Парам); 
	
	Отказ = Ложь;
	
	ДанныеАвтозаполнения = ДокументОбъект.ВыполнитьАвтозаполнение(Отказ);  
	
	Для Каждого элДанные из ДанныеАвтозаполнения Цикл
		НоваяСтрока = ДокументОбъект.Услуги.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, элДанные); 
	КонецЦикла;	                                         
	
	Если Не Отказ Тогда
		ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);   
	КонецЕсли;
	
	Возврат ДокументОбъект.Ссылка;	
	
КонецФункции  

#КонецОбласти
#КонецЕсли
