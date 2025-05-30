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

#Область ОписаниеПеременных

// Список поддерживаемых форматов отчетов
&НаКлиенте
Перем ПоддерживаемыеФорматыОтчетов;

// Флаг необходимости отображения вопроса перед закрытием формы
&НаКлиенте
Перем НеЗадаватьВопросПриЗакрытии;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Для Каждого УровеньЛог Из ЮТЛогирование.УровниЛога() Цикл
		Элементы.УровеньЛога.СписокВыбора.Добавить(УровеньЛог.Значение, УровеньЛог.Ключ);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьПараметрыПоУмолчанию();
	
	ПоддерживаемыеФорматыОтчетов = ЮТОтчетСлужебный.ПоддерживаемыеФорматыОтчетов();
	Для Каждого Формат Из ПоддерживаемыеФорматыОтчетов Цикл
		Элементы.ФорматОтчета.СписокВыбора.Добавить(Формат.Ключ, Формат.Значение.Представление);
	КонецЦикла;
	
	НеЗадаватьВопросПриЗакрытии = Ложь;
	
	ПодключитьОбработчикОжидания("ЗагрузитьЗарегистрированныеТесты", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ЗавершениеРаботы Или НеЗадаватьВопросПриЗакрытии Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	Обработчик = Новый ОписаниеОповещения("ОбработкаПодтвержденияЗакрытия", ЭтотОбъект);
	ПоказатьВопрос(Обработчик, "Закрыть окно работы с тестами?", РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ФайлКонфигурацииНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Обработчик = Новый ОписаниеОповещения("УстановитьФайлКонфигурации", ЭтотОбъект);
	ЮТПользовательскийИнтерфейсСлужебныйКлиент.ВыбратьСохраняемыйФайл("*.json|*.json", ФайлКонфигурации, Обработчик);
	
КонецПроцедуры

&НаКлиенте
Процедура КаталогПроектаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Обработчик = Новый ОписаниеОповещения("СохранитьИмяФайлаВРеквизит", ЭтотОбъект, "КаталогПроекта");
	ЮТПользовательскийИнтерфейсСлужебныйКлиент.ВыбратьКаталог(КаталогПроекта, Обработчик);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗапускИзПредприятияПриИзменении(Элемент)
	
	ОбновитьСтрокуЗапуска();
	
КонецПроцедуры

&НаКлиенте
Процедура ФайлКонфигурацииПриИзменении(Элемент)
	
	ОбновитьСтрокуЗапуска();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыводЛогаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Обработчик = Новый ОписаниеОповещения("СохранитьИмяФайлаВРеквизит", ЭтотОбъект, "ИмяФайлаЛога");
	ЮТПользовательскийИнтерфейсСлужебныйКлиент.ВыбратьСохраняемыйФайл("*.log|*.log|*.txt|*.txt|All files(*.*)|*.*", ИмяФайлаЛога, Обработчик);
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаКодаВозвратаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Обработчик = Новый ОписаниеОповещения("СохранитьИмяФайлаВРеквизит", ЭтотОбъект, "ИмяФайлаКодаВозврата");
	ЮТПользовательскийИнтерфейсСлужебныйКлиент.ВыбратьСохраняемыйФайл("All files(*.*)|*.*", ИмяФайлаКодаВозврата, Обработчик);
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаОтчетаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОписаниеФормата = Неопределено;
	Если НЕ ПоддерживаемыеФорматыОтчетов.Свойство(ФорматОтчета, ОписаниеФормата) Тогда
		ПоказатьПредупреждение(, "Сначала укажите формат отчета");
		Возврат;
	КонецЕсли;
	
	Обработчик = Новый ОписаниеОповещения("СохранитьИмяФайлаВРеквизит", ЭтотОбъект, "ИмяФайлаОтчета");
	Если ОписаниеФормата.ЗаписьВКаталог Тогда
		ЮТПользовательскийИнтерфейсСлужебныйКлиент.ВыбратьКаталог(ИмяФайлаОтчета, Обработчик);
	Иначе
		ЮТПользовательскийИнтерфейсСлужебныйКлиент.ВыбратьСохраняемыйФайл(ОписаниеФормата.ФильтрВыбораФайла, ИмяФайлаОтчета, Обработчик);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоТестов

&НаКлиенте
Процедура ДеревоТестовОтметкаПриИзменении(Элемент)
	
	Данные = Элементы.ДеревоТестов.ТекущиеДанные;
	
	Если Данные.Отметка = 2 Тогда
		Данные.Отметка = 0;
	КонецЕсли;
	
	УстановитьРекурсивноЗначение(Данные.ПолучитьЭлементы(), Данные.Отметка);
	ОбновитьОтметкиРодителей(Данные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СнятьФлажки(Команда)
	
	УстановитьРекурсивноЗначение(ДеревоТестов.ПолучитьЭлементы(), 0);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьФлажки(Команда)
	
	УстановитьРекурсивноЗначение(ДеревоТестов.ПолучитьЭлементы(), 1);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПараметры(Команда)
	
	Если НЕ ЕстьОтмеченныеТесты() Тогда
		ПоказатьПредупреждение(, "Отметьте тесты, которые должны выполниться");
		Возврат;
	КонецЕсли;
	
	Если ПустаяСтрока(ФайлКонфигурации) Тогда
		Обработчик = Новый ОписаниеОповещения("СохранитьПараметрыПослеВыбораФайла", ЭтотОбъект);
		ЮТПользовательскийИнтерфейсСлужебныйКлиент.ВыбратьСохраняемыйФайл("*.json|*.json", ФайлКонфигурации, Обработчик);
	Иначе
		СохранитьПараметрыПослеВыбораФайла(ФайлКонфигурации);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОтобразитьДеревоТестов(ТестовыеМодули, ДополнительныеПараметры) Экспорт
	
	СтрокиРасширений = Новый Соответствие();
	
	Для Каждого ОписаниеМодуля Из ТестовыеМодули Цикл
		
		ИмяРасширения = ОписаниеМодуля.Метаданные.Расширение;
		
		СтрокаРасширения = СтрокаРасширения(ДеревоТестов, СтрокиРасширений, ИмяРасширения);
		СтрокаМодуля = ДобавитьСтрокуМодуля(СтрокаРасширения, ОписаниеМодуля.Метаданные);
		
		Если ОписаниеМодуля.НаборыТестов.Количество() = 1 Тогда
			
			Для Каждого Тест Из ОписаниеМодуля.НаборыТестов[0].Тесты Цикл
				
				ДобавитьСтрокуТеста(СтрокаМодуля, Тест);
				
			КонецЦикла;
			
		Иначе
			
			Для Каждого Набор Из ОписаниеМодуля.НаборыТестов Цикл
				
				СтрокаНабора = ДобавитьСтрокуНабора(СтрокаМодуля, Набор);
				
				Для Каждого Тест Из Набор.Тесты Цикл
					
					ДобавитьСтрокуТеста(СтрокаНабора, Тест);
					
				КонецЦикла;
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция СтрокаРасширения(ДеревоТестов, СтрокиРасширений, ИмяРасширения)
	
	СтрокаРасширения = СтрокиРасширений[ИмяРасширения];
	Если СтрокаРасширения = Неопределено Тогда
		СтрокаРасширения = ДеревоТестов.ПолучитьЭлементы().Добавить();
		СтрокаРасширения.Идентификатор = ИмяРасширения;
		СтрокаРасширения.Представление = ИмяРасширения;
		СтрокаРасширения.ТипОбъекта = 0;
		
		СтрокиРасширений.Вставить(ИмяРасширения, СтрокаРасширения);
	КонецЕсли;
	
	Возврат СтрокаРасширения;
		
КонецФункции

&НаКлиенте
Функция ДобавитьСтрокуМодуля(Владелец, МетаданныеМодуля)
	
	Строка = Владелец.ПолучитьЭлементы().Добавить();
	Строка.Идентификатор = МетаданныеМодуля.Имя;
	Строка.Представление = МетаданныеМодуля.Имя;
	Строка.ТипОбъекта = 1;
	
	Возврат Строка;
	
КонецФункции

&НаКлиенте
Функция ДобавитьСтрокуНабора(Владелец, Набор)
	
	Строка = Владелец.ПолучитьЭлементы().Добавить();
	Строка.Идентификатор = Набор.Имя;
	Строка.Представление = Набор.Представление;
	Строка.ТипОбъекта = 2;
	
	Возврат Строка;
	
КонецФункции

&НаКлиенте
Функция ДобавитьСтрокуТеста(Владелец, Тест)
	
	Представление = ЮТФабрикаСлужебный.ПредставлениеТеста(Тест);
	
	Если Владелец.ТипОбъекта = 1 Тогда
		СтрокаМодуля = Владелец;
	Иначе
		СтрокаМодуля = Владелец.ПолучитьРодителя();
	КонецЕсли;
	
	Строка = Владелец.ПолучитьЭлементы().Добавить();
	Строка.Идентификатор = СтрШаблон("%1.%2", СтрокаМодуля.Идентификатор, Тест.Имя);
	Строка.Представление = СтрШаблон("%1, %2", Представление, СтрСоединить(Тест.КонтекстВызова, ", "));
	Строка.ТипОбъекта = 3;
	
	Возврат Строка;
	
КонецФункции

&НаКлиенте
Процедура УстановитьРекурсивноЗначение(Элементы, Значение, Колонка = "Отметка")
	
	Для Каждого Элемент Из Элементы Цикл
		
		Элемент[Колонка] = Значение;
		
		Если ЗначениеЗаполнено(Элемент.ПолучитьЭлементы()) Тогда
			УстановитьРекурсивноЗначение(Элемент.ПолучитьЭлементы(), Значение, Колонка);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьОтметкиРодителей(Элемент)
	
	Родитель = Элемент.ПолучитьРодителя();
	
	Если Родитель = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЕстьСОтметкой = Ложь;
	ЕстьБезОтметки = Ложь;
	
	Для Каждого Элемент Из Родитель.ПолучитьЭлементы() Цикл
		
		Если Элемент.Отметка = 0 Тогда
			ЕстьБезОтметки = Истина;
		ИначеЕсли Элемент.Отметка = 1 Тогда
			ЕстьСОтметкой = Истина;
		ИначеЕсли Элемент.Отметка = 2 Тогда
			ЕстьБезОтметки = Истина;
			ЕстьСОтметкой = Истина;
		КонецЕсли;
		
		Если ЕстьБезОтметки И ЕстьСОтметкой Тогда
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Если ЕстьСОтметкой И ЕстьБезОтметки Тогда
		НоваяОтметка = 2;
	ИначеЕсли ЕстьСОтметкой Тогда
		НоваяОтметка = 1;
	Иначе
		НоваяОтметка = 0;
	КонецЕсли;
	
	Если Родитель.Отметка = НоваяОтметка Тогда
		Возврат;
	КонецЕсли;
	
	Родитель.Отметка = НоваяОтметка;
	ОбновитьОтметкиРодителей(Родитель);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСтрокуЗапуска()
	
	ПараметрыЗапускаЮнитТестов = СтрШаблон("%1=%2", ЮТПараметрыЗапускаСлужебный.КлючЗапуска(), ФайлКонфигурации);
	
	Если ЗапускИзКонфигуратор Тогда
		
		ПараметрыЗапуска = ПараметрыЗапускаЮнитТестов;
		
	Иначе
		
#Если ВебКлиент Тогда
		ВызватьИсключение "Формирование строки запуска для веб-клиенте не поддерживается";
#Иначе
		СистемнаяИнформация = Новый СистемнаяИнформация;
#Если ТонкийКлиент Тогда
		Файл = "1cv8c";
#Иначе
		Файл = "1cv8";
#КонецЕсли
		ПутьЗапускаемогоКлиента = ЮТФайлы.ОбъединитьПути(КаталогПрограммы(), Файл);
		Аргументы = Новый Массив;
		
		Если СистемнаяИнформация.ТипПлатформы = ТипПлатформы.Windows_x86 Или СистемнаяИнформация.ТипПлатформы = ТипПлатформы.Windows_x86_64 Тогда
			ПутьЗапускаемогоКлиента = ПутьЗапускаемогоКлиента + ".exe";
		КонецЕсли;
		
#Если ТолстыйКлиентОбычноеПриложение Тогда
		Аргументы.Добавить("ENTERPRISE /RunModeOrdinaryApplication");
#ИначеЕсли ТолстыйКлиентУправляемоеПриложение Тогда
		Аргументы.Добавить("ENTERPRISE /RunModeManagedApplication");
#КонецЕсли
		
		Аргументы.Добавить(СтрШаблон("/IBConnectionString ""%1""", СтрЗаменить(СтрокаСоединенияИнформационнойБазы(), """", """""")));
		Аргументы.Добавить(СтрШаблон("/C ""%1""", ПараметрыЗапускаЮнитТестов));
		
		Если ЗначениеЗаполнено(ИмяПользователя()) Тогда
			Аргументы.Добавить(СтрШаблон("/N""%1""", ИмяПользователя()));
		КонецЕсли;
		
		ПараметрыЗапуска = СтрШаблон("""%1"" %2", ПутьЗапускаемогоКлиента, СтрСоединить(Аргументы, " "));
#КонецЕсли
	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПараметрыПослеВыбораФайла(ВыбранныйФайл, ДополнительныеПараметры = Неопределено) Экспорт
	
	ФайлКонфигурации = ВыбранныйФайл;
	ОбновитьСтрокуЗапуска();
	СохранитьКонфигурациюЗапуска();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьФайлКонфигурации(ВыбранныйФайл, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныйФайл <> Неопределено Тогда
		ФайлКонфигурации = ВыбранныйФайл;
		ОбновитьСтрокуЗапуска();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьИмяФайлаВРеквизит(ВыбранныйФайл, ИмяРеквизита) Экспорт
	
	Если ВыбранныйФайл <> Неопределено Тогда
		ЭтотОбъект[ИмяРеквизита] = ВыбранныйФайл;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьКонфигурациюЗапуска()
	
#Если ВебКлиент Тогда
	ВызватьИсключение "Сохранение конфигурации из веб-клиента не поддерживается";
#Иначе
	Конфигурация = ЮТПараметрыЗапускаСлужебный.ПараметрыТестированияПоУмолчанию();
	Конфигурация.Удалить("ВыполнятьМодульноеТестирование");
	
	Конфигурация.showReport = ОтобразитьОтчет;
	Конфигурация.closeAfterTests = ЗакрытьПослеТестирования;
	Конфигурация.reportFormat = ФорматОтчета;
	Конфигурация.reportPath = ИмяФайлаОтчета;
	Конфигурация.projectPath = КаталогПроекта;
	
	Конфигурация.logging.level = УровеньЛога;
	Конфигурация.logging.file = ИмяФайлаЛога;
	Конфигурация.logging.console = ЛогированиеВКонсоль;
	
	Если ЗначениеЗаполнено(ИмяФайлаКодаВозврата) Тогда
		Конфигурация.exitCode = ИмяФайлаКодаВозврата;
	КонецЕсли;
	
	Конфигурация.filter.Очистить();
	
	Если НЕ (УстановленФильтрПоРасширению(Конфигурация) ИЛИ УстановленФильтрПоМодулям(Конфигурация)) Тогда
		УстановитьФильтрПоТестам(Конфигурация);
	КонецЕсли;
	
	Запись = Новый ЗаписьJSON();
	СимволыОтступа = "  ";
	ПараметрыЗаписи = Новый ПараметрыЗаписиJSON(, СимволыОтступа);
	Запись.ОткрытьФайл(ФайлКонфигурации, , , ПараметрыЗаписи);
	ЗаписатьJSON(Запись, Конфигурация);
	Запись.Закрыть();
#КонецЕсли
	
КонецПроцедуры

&НаКлиенте
Функция ЕстьОтмеченныеТесты()
	
	Для Каждого СтрокаРасширения Из ДеревоТестов.ПолучитьЭлементы() Цикл
		Если СтрокаРасширения.Отметка > 0 Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

&НаКлиенте
Функция УстановленФильтрПоРасширению(Конфигурация)
	
	Расширения = Новый Массив();
	Для Каждого СтрокаРасширения Из ДеревоТестов.ПолучитьЭлементы() Цикл
		
		Если СтрокаРасширения.Отметка = 2 Тогда
			Возврат Ложь;
		ИначеЕсли СтрокаРасширения.Отметка = 1 Тогда
			Расширения.Добавить(СтрокаРасширения.Идентификатор);
		КонецЕсли;
		
	КонецЦикла;
	
	Если Расширения.Количество() Тогда
		Конфигурация.filter.Вставить("extensions",Расширения);
	КонецЕсли;
	
	Возврат Расширения.Количество() > 0;
	
КонецФункции

&НаКлиенте
Функция УстановленФильтрПоМодулям(Конфигурация)
	
	Модули = Новый Массив();
	
	Для Каждого СтрокаРасширения Из ДеревоТестов.ПолучитьЭлементы() Цикл
		
		Если СтрокаРасширения.Отметка = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		Для Каждого СтрокаМодуля Из СтрокаРасширения.ПолучитьЭлементы() Цикл
			
			Если СтрокаМодуля.Отметка = 2 Тогда
				Возврат Ложь;
			ИначеЕсли СтрокаМодуля.Отметка = 1 Тогда
				Модули.Добавить(СтрокаМодуля.Идентификатор);
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	Если Модули.Количество() Тогда
		Конфигурация.filter.Вставить("modules", Модули);
	КонецЕсли;
	
	Возврат Модули.Количество() > 0;
	
КонецФункции

&НаКлиенте
Процедура УстановитьФильтрПоТестам(Конфигурация)
	
	Тесты = Новый Массив();
	ДобавитьОтмеченныеТесты(ДеревоТестов.ПолучитьЭлементы(), Тесты);
	
	Конфигурация.filter.Вставить("tests", Тесты);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьОтмеченныеТесты(Строки, Тесты)
	
	Для Каждого Строка Из Строки Цикл
		Если Строка.Отметка = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		Если Строка.ТипОбъекта = 3 Тогда
			Тесты.Добавить(Строка.Идентификатор);
		Иначе
			ДобавитьОтмеченныеТесты(Строка.ПолучитьЭлементы(), Тесты);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаПодтвержденияЗакрытия(Ответ, ДополнительныеПараметры) Экспорт
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		НеЗадаватьВопросПриЗакрытии = Истина;
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПараметрыПоУмолчанию()
	
	Конфигурация = ЮТПараметрыЗапускаСлужебный.ПараметрыТестированияПоУмолчанию();
	ФорматОтчета = Конфигурация.reportFormat;
	УровеньЛога = Конфигурация.logging.level;
	ОтобразитьОтчет = Конфигурация.showReport;
	ЗакрытьПослеТестирования = Конфигурация.closeAfterTests;
	КаталогПроекта = Конфигурация.projectPath;
	ЛогированиеВКонсоль = Конфигурация.logging.console;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьЗарегистрированныеТесты()
	
	Обработчик = Новый ОписаниеОповещения("ОтобразитьДеревоТестов", ЭтотОбъект);
	ЮТИсполнительСлужебныйКлиент.ЗагрузитьЗарегистрированныеТесты(ЮТФабрика.ПараметрыЗапуска(), Обработчик);
	
КонецПроцедуры

#КонецОбласти
