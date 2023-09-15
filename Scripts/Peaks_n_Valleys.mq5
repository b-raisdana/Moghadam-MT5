//+------------------------------------------------------------------+
//|                                              Peaks_n_Valleys.mq5 |
//|                                                          Behrooz |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Behrooz"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                     DrawPeaks.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "2023"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//|                                                     DrawPeaks.mq5 |
//|                        Copyright 2023, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <FileCSV.mqh>
#include <Arrays\ArrayString.mqh>
#include <Timeframe.mqh>

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   CFileCSV fileCSV;
   string file_name = "multi_timeframe_peaks_n_valleys.csv";
   if(fileCSV.Open(file_name, FILE_READ|FILE_CSV|FILE_ANSI))
   {
      string line;
      fileCSV.Read(line); // Read the header
      if (line != "timeframe,date,open,high,low,close,volume,peak_or_valley,strength"){
         Print("Invalid input file format in "+ file_name +line);
         return -1;
      }
      while(fileCSV.Read(line))
      {
         string parts[];
         StringSplit(line, ',', parts);
         string timeframe = parts[0];
         datetime time = StringToTime(parts[1]);
         double high = StringToDouble(parts[3]);
         double low = StringToDouble(parts[4]);
         string peak_or_valley = parts[7];
         color timeframe_color = TimeFrameColor(timeframe);

         if(peak_or_valley == "valley")
         {
            ObjectCreate(0, "ArrowDown"+IntegerToString(time), OBJ_ARROW_DOWN, 0, time, high);
            ObjectSetInteger(0, "ArrowDown"+IntegerToString(time), OBJPROP_COLOR, timeframe_color);
         }
         else if(peak_or_valley == "peak")
         {
            ObjectCreate(0, "ArrowUp"+IntegerToString(time), OBJ_ARROW_UP, 0, time, low);
            ObjectSetInteger(0, "ArrowUp"+IntegerToString(time), OBJPROP_COLOR, timeframe_color);
         }
      }
      fileCSV.Close();
   }
   else
   {
      Print("Failed to open file. Error code: ", GetLastError());
   }
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
