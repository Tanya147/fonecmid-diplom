#Область ОбработчикиСобытий
Функция pingGETPing(Запрос)
	//Ответ = Новый HTTPСервисОтвет(200);
	//Ответ.УстановитьТелоИзСтроки("OK");
	Возврат вкм_РаботаСHTTP.ПростойУспешныйОтвет();
КонецФункции

Функция SendPOST(Запрос)
	УстановитьПривилегированныйРежим(Истина);
	Попытка
		Ответ = вкм_Телеграмм.ОбработатьВходящийЗапрос(Запрос);
		//Ответ = вкм_РаботаСHTTP.ПростойУспешныйОтвет();
	Исключение
		ИнформацияОбОшибке = ИнформацияОбОшибке();
		Ответ =  вкм_РаботаСHTTP.ОтветОбОшибке(ИнформацияОбОшибке);
	КонецПопытки;
	вкм_РаботаСHTTP.ЗаписьЛога("Send", Запрос, Ответ);
	Возврат Ответ;
КонецФункции
#КонецОбласти


