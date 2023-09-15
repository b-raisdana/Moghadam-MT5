//+------------------------------------------------------------------+
//|                                                    Timeframe.mqh |
//|                                                          Behrooz |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Behrooz"
#property link      "https://www.mql5.com"
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+
int TimeframeToPeriod(string freq)
{
   if (StringFind(freq, "min") >= 0)
   {
      int minutes = int(StringToInteger(StringSubstr(freq, 0, StringFind(freq, "min"))));
      return minutes;
   }
   else if (StringFind(freq, "H") >= 0)
   {
      int hours = int(StringToInteger(StringSubstr(freq, 0, StringFind(freq, "H"))));
      return hours * 60; // Convert hours to minutes
   }
   else if (StringFind(freq, "D") >= 0)
   {
      return PERIOD_D1; // Daily timeframe
   }
   else if (StringFind(freq, "W") >= 0)
   {
      return PERIOD_W1; // Weekly timeframe
   }
   else if (StringFind(freq, "M") >= 0)
   {
      return PERIOD_MN1; // Monthly timeframe
   }
   else
   {
      return -1; // Invalid frequency string
   }
}
int PeriodToIndex(int period){
   if(period <= 0) return -1; // Return -1 if the input is non-positive to prevent log(0) or log(negative number)

   double result = MathLog(period)/MathLog(2)/2.0;
   return (int)MathRound(result);
}
int TimeframeToIndex(string timeframe)
{
   int period = TimeframeToPeriod(timeframe);
   return PeriodToIndex(period);
}

color timeframe_color_map[] ={
   clrRed,              // 1min
   clrOrange,           // 5min
   clrYellow,           // 15min
   clrLemonChiffon,     // 1H
   clrGreen,            // 4H
   clrCyan,             // 1D
   C'1F,45,6E',             // 4D
   clrBlue,             // 1W
};
color TimeFrameColor(string timeframe)
{
   int timeframe_index = TimeframeToIndex(timeframe);
   int number_of_colors = ArraySize(timeframe_color_map);
   int color_index = int(MathMod(timeframe_index, number_of_colors));
   return timeframe_color_map[color_index];
}
