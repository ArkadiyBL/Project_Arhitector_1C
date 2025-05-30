﻿//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2025 BIA-Technologies Limited Liability Company
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//©///////////////////////////////////////////////////////////////////////////©//

///////////////////////////////////////////////////////////////////
// Предоставляет методы для формирования утверждений проверяющих данные информационной базы.
// 
// Например:
// 
// ```bsl
// ЮТест.ОжидаетЧтоТаблицаБазы("Справочник.Товары")
//   .СодержитЗаписи();
// ЮТест.ОжидаетЧтоТаблицаБазы("РегистрСведений.КурсыВалют")
//   .СодержитЗаписи(ЮТест.Предикат()
//     .Реквизит("Валюта").Равно(ДанныеРегистра.Валюта));
// ```
///////////////////////////////////////////////////////////////////
#Область ПрограммныйИнтерфейс

// Инициализирует модуль для проверки утверждений.
// 
// * Запоминает/устанавливает имя проверяемой таблицы
// * Запоминает описание.
// 
// Параметры:
//  ИмяТаблицы - Строка - Имя проверяемой таблицы, например, Справочник.Товары, РегистрНакопления.ТоварыНаСкладах
//  ОписаниеПроверки - Строка - Описание проверки, которое будет выведено при возникновении ошибки
// 
// Возвращаемое значение:
//  CommonModule.ЮТУтвержденияИБ - Этот модуль для замыкания
// Примеры
//  ЮТест.ОжидаетЧтоТаблицаБазы("Справочник.Товары").СодержитЗаписи();
//
Функция ЧтоТаблица(ИмяТаблицы, ОписаниеПроверки = "") Экспорт
	
	Контекст = НовыйКонтекст(ИмяТаблицы);
	Контекст.ПрефиксОшибки = ОписаниеПроверки;
	
	ЮТКонтекстСлужебный.УстановитьЗначениеКонтекста(ИмяКонтекста(), Контекст);
	
	Возврат ЮТУтвержденияИБ;
	
КонецФункции

// Проверяет наличие в таблице записей удовлетворяющих условиям
// 
// Параметры:
//  Предикат - ОбщийМодуль - Модуль настройки предикатов, см. ЮТест.Предикат
//           - Массив из см. ЮТФабрика.ВыражениеПредиката - Набор условий, см. ЮТПредикаты.Получить
//           - см. ЮТФабрика.ВыражениеПредиката
//           - Неопределено - Проверит, что таблица не пустая 
//  ОписаниеУтверждения - Строка - Описание конкретного утверждения
// 
// Возвращаемое значение:
//  CommonModule.ЮТУтвержденияИБ - Этот модуль для замыкания
Функция СодержитЗаписи(Знач Предикат = Неопределено, Знач ОписаниеУтверждения = Неопределено) Экспорт
	
	Контекст = Контекст();
	УстановитьОписаниеПроверки(Контекст, ОписаниеУтверждения);
	Результат = ЮТЗапросы.ТаблицаСодержитЗаписи(Контекст.ОбъектПроверки.Значение, Предикат);
	
	Если Не Результат Тогда
		Контекст = Контекст();
		СгенерироватьОшибкуУтверждения(Контекст, Предикат, "содержит записи");
	КонецЕсли;
	
	Возврат ЮТУтвержденияИБ;
	
КонецФункции

// Проверяет отсутствие в таблице записей удовлетворяющих условиям
// 
// Параметры:
//  Предикат - ОбщийМодуль - Условия сформированные с использованием см. ЮТест.Предикат
//           - Массив из см. ЮТФабрика.ВыражениеПредиката - Набор условий, см. ЮТПредикаты.Получить
//           - см. ЮТФабрика.ВыражениеПредиката
//           - Неопределено - Проверит, что таблица пустая 
//  ОписаниеУтверждения - Строка - Описание конкретного утверждения
// 
// Возвращаемое значение:
//  CommonModule.ЮТУтвержденияИБ - Этот модуль для замыкания
Функция НеСодержитЗаписи(Знач Предикат = Неопределено, Знач ОписаниеУтверждения = Неопределено) Экспорт
	
	Контекст = Контекст();
	УстановитьОписаниеПроверки(Контекст, ОписаниеУтверждения);
	Результат = НЕ ЮТЗапросы.ТаблицаСодержитЗаписи(Контекст.ОбъектПроверки.Значение, Предикат);
	
	Если Не Результат Тогда
		Контекст = Контекст();
		СгенерироватьОшибкуУтверждения(Контекст, Предикат, "не содержит записи");
	КонецЕсли;
	
	Возврат ЮТУтвержденияИБ;
	
КонецФункции

// Проверяет наличие в таблице записей с указанным наименованием
// 
// Параметры:
//  ОжидаемоеНаименование - Строка
//  ПроверятьПометкуУдаления - Булево - Проверять пометку удаления.
//        + `Истина` - Подбираются только непомеченные на удаление записи.
//        + `Ложь` - пометка на удаление игнорируется
//  
//  ОписаниеУтверждения - Строка - Описание конкретного утверждения
// 
// Возвращаемое значение:
//  CommonModule.ЮТУтвержденияИБ - Этот модуль для замыкания
Функция СодержитЗаписиСНаименованием(ОжидаемоеНаименование, ПроверятьПометкуУдаления = Истина, ОписаниеУтверждения = Неопределено) Экспорт
	
	Условия = ПредикатПоискаПоРеквизиту("Наименование", ОжидаемоеНаименование, ПроверятьПометкуУдаления);
	Возврат СодержитЗаписи(Условия, ОписаниеУтверждения);
	
КонецФункции

// Проверяет, что в таблице содержится только одна запись удовлетворяющая условиям
//
// Параметры:
//  Предикат - ОбщийМодуль - Модуль настройки предикатов, см. ЮТест.Предикат
//           - Массив из см. ЮТФабрика.ВыражениеПредиката - Набор условий, см. ЮТПредикаты.Получить
//           - см. ЮТФабрика.ВыражениеПредиката
//           - Неопределено - Проверит, что таблица не пустая 
//  ОписаниеУтверждения - Строка - Описание конкретного утверждения
//
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция СодержитТолькоОднуЗапись(Знач Предикат = Неопределено, Знач ОписаниеУтверждения = Неопределено) Экспорт
	
	Контекст = Контекст();
	УстановитьОписаниеПроверки(Контекст, ОписаниеУтверждения);
	ФактическоеКоличествоЗаписей = ЮТЗапросы.КоличествоЗаписей(Контекст.ОбъектПроверки.Значение, Предикат);
	
	Если ФактическоеКоличествоЗаписей <> 1 Тогда
		Контекст = Контекст();
		СгенерироватьОшибкуУтверждения(Контекст, Предикат, "содержит только одну запись");
	КонецЕсли;
	
	Возврат ЮТУтвержденияИБ;
	
КонецФункции

// Проверяет, что в таблице содержится несколько записей удовлетворяющих условиям
//
// Параметры:
//  КоличествоЗаписей - Число - Ожидаемое количество записей в таблицы
//  Предикат - ОбщийМодуль - Модуль настройки предикатов, см. ЮТест.Предикат
//           - Массив из см. ЮТФабрика.ВыражениеПредиката - Набор условий, см. ЮТПредикаты.Получить
//           - см. ЮТФабрика.ВыражениеПредиката
//           - Неопределено - Проверит, что таблица не пустая 
//  ОписаниеУтверждения - Строка - Описание конкретного утверждения
//
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция СодержитНесколькоЗаписей(Знач КоличествоЗаписей, Знач Предикат = Неопределено, Знач ОписаниеУтверждения = Неопределено) Экспорт
	
	Контекст = Контекст();
	УстановитьОписаниеПроверки(Контекст, ОписаниеУтверждения);
	ФактическоеКоличествоЗаписей = ЮТЗапросы.КоличествоЗаписей(Контекст.ОбъектПроверки.Значение, Предикат);
	
	Если ФактическоеКоличествоЗаписей <> КоличествоЗаписей Тогда
		Контекст = Контекст();
		Сообщение = СтрШаблон("содержит несколько записей (%1)", КоличествоЗаписей);
		СгенерироватьОшибкуУтверждения(Контекст, Предикат, Сообщение);
	КонецЕсли;
	
	Возврат ЮТУтвержденияИБ;
	
КонецФункции

// Проверяет наличие в таблице записей с указанным кодом
// 
// Параметры:
//  ОжидаемыйКод - Строка
//  ПроверятьПометкуУдаления - Булево - Проверять пометку удаления.
//        + `Истина` - Подбираются только непомеченные на удаление записи.
//        + `Ложь` - пометка на удаление игнорируется
//  
//  ОписаниеУтверждения - Строка - Описание конкретного утверждения
// 
// Возвращаемое значение:
//  CommonModule.ЮТУтвержденияИБ - Этот модуль для замыкания
Функция СодержитЗаписиСКодом(ОжидаемыйКод, ПроверятьПометкуУдаления = Истина, ОписаниеУтверждения = Неопределено) Экспорт
	
	Условия = ПредикатПоискаПоРеквизиту("Код", ОжидаемыйКод, ПроверятьПометкуУдаления);
	Возврат СодержитЗаписи(Условия, ОписаниеУтверждения);
	
КонецФункции

// Проверяет наличие в таблице записей с указанным номером
// 
// Параметры:
//  ОжидаемыйНомер - Строка
//  ПроверятьПометкуУдаления - Булево - Проверять пометку удаления.
//        + `Истина` - Подбираются только непомеченные на удаление записи.
//        + `Ложь` - пометка на удаление игнорируется
//  
//  ОписаниеУтверждения - Строка - Описание конкретного утверждения
// 
// Возвращаемое значение:
//  CommonModule.ЮТУтвержденияИБ - Этот модуль для замыкания
Функция СодержитЗаписиСНомером(ОжидаемыйНомер, ПроверятьПометкуУдаления = Истина, ОписаниеУтверждения = Неопределено) Экспорт
	
	Условия = ПредикатПоискаПоРеквизиту("Номер", ОжидаемыйНомер, ПроверятьПометкуУдаления);
	Возврат СодержитЗаписи(Условия, ОписаниеУтверждения);
	
КонецФункции

// Проверяет отсутствие в таблице записей с указанным наименованием
// 
// Параметры:
//  ОжидаемоеНаименование - Строка
//  ПроверятьПометкуУдаления - Булево - Проверять пометку удаления.
//        + `Истина` - Подбираются только непомеченные на удаление записи.
//        + `Ложь` - пометка на удаление игнорируется
//  
//  ОписаниеУтверждения - Строка - Описание конкретного утверждения
// 
// Возвращаемое значение:
//  CommonModule.ЮТУтвержденияИБ - Этот модуль для замыкания
Функция НеСодержитЗаписиСНаименованием(ОжидаемоеНаименование, ПроверятьПометкуУдаления = Истина, ОписаниеУтверждения = Неопределено) Экспорт
	
	Условия = ПредикатПоискаПоРеквизиту("Наименование", ОжидаемоеНаименование, ПроверятьПометкуУдаления);
	Возврат НеСодержитЗаписи(Условия, ОписаниеУтверждения);
	
КонецФункции

// Проверяет отсутствие в таблице записей с указанным кодом
// 
// Параметры:
//  ОжидаемыйКод - Строка
//  ПроверятьПометкуУдаления - Булево - Проверять пометку удаления.
//        + `Истина` - Подбираются только непомеченные на удаление записи.
//        + `Ложь` - пометка на удаление игнорируется
//  
//  ОписаниеУтверждения - Строка - Описание конкретного утверждения
// 
// Возвращаемое значение:
//  CommonModule.ЮТУтвержденияИБ - Этот модуль для замыкания
Функция НеСодержитЗаписиСКодом(ОжидаемыйКод, ПроверятьПометкуУдаления = Истина, ОписаниеУтверждения = Неопределено) Экспорт
	
	Условия = ПредикатПоискаПоРеквизиту("Код", ОжидаемыйКод, ПроверятьПометкуУдаления);
	Возврат НеСодержитЗаписи(Условия, ОписаниеУтверждения);
	
КонецФункции

// Проверяет отсутствие в таблице записей с указанным номером
// 
// Параметры:
//  ОжидаемыйНомер - Строка
//  ПроверятьПометкуУдаления - Булево - Проверять пометку удаления.
//        + `Истина` - Подбираются только непомеченные на удаление записи.
//        + `Ложь` - пометка на удаление игнорируется
//  
//  ОписаниеУтверждения - Строка - Описание конкретного утверждения
// 
// Возвращаемое значение:
//  CommonModule.ЮТУтвержденияИБ - Этот модуль для замыкания
Функция НеСодержитЗаписиСНомером(ОжидаемыйНомер, ПроверятьПометкуУдаления = Истина, ОписаниеУтверждения = Неопределено) Экспорт
	
	Условия = ПредикатПоискаПоРеквизиту("Номер", ОжидаемыйНомер, ПроверятьПометкуУдаления);
	Возврат НеСодержитЗаписи(Условия, ОписаниеУтверждения);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Контекст

// Контекст.
// 
// Возвращаемое значение:
//  см. НовыйКонтекст
Функция Контекст()
	
	//@skip-check constructor-function-return-section
	Возврат ЮТКонтекстСлужебный.ЗначениеКонтекста(ИмяКонтекста());
	
КонецФункции

// Инициализирует контекст
// 
// Параметры:
//  ИмяТаблицы - Строка
//  
// Возвращаемое значение:
//  см. ЮТФабрикаСлужебный.ОписаниеПроверки
Функция НовыйКонтекст(ИмяТаблицы)
	
	Контекст = ЮТФабрикаСлужебный.ОписаниеПроверки(ИмяТаблицы);
	
	Возврат Контекст;
	
КонецФункции

Функция ИмяКонтекста()
	
	Возврат "КонтекстУтвержденияИБ";
	
КонецФункции

#КонецОбласти

Процедура СгенерироватьОшибкуУтверждения(Контекст, Предикат, Сообщение)
	
	Если Предикат <> Неопределено Тогда
		ПредставлениеПредиката = ЮТПредикатыСлужебныйКлиентСервер.ПредставлениеПредикатов(Предикат, ", ", "`%1`");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ПредставлениеПредиката) Тогда
		СообщениеОбОшибке = СтрШаблон("%1 с %2", Сообщение, ПредставлениеПредиката);
	Иначе
		СообщениеОбОшибке = Сообщение;
	КонецЕсли;
	
	ЮТРегистрацияОшибокСлужебный.СгенерироватьОшибкуУтверждения(Контекст, СообщениеОбОшибке, Неопределено, "проверяемая таблица");
	
КонецПроцедуры

Процедура УстановитьОписаниеПроверки(Контекст, ОписаниеПроверки)
	
	Контекст.ОписаниеПроверки = ОписаниеПроверки;
	
КонецПроцедуры

Функция ПредикатПоискаПоРеквизиту(ИмяРеквизита, ЗначениеРеквизита, ПроверятьПометкуУдаления)
	
	Условия = ЮТПредикаты.Инициализировать()
		.Реквизит(ИмяРеквизита).Равно(ЗначениеРеквизита);
		
	Если ПроверятьПометкуУдаления Тогда
		Условия.Реквизит("ПометкаУдаления").Равно(Ложь);
	КонецЕсли;
	
	Возврат Условия;
	
КонецФункции

#КонецОбласти
