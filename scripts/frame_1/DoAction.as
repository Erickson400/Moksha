function Loading()
{
   gotim += 1;
   meter = GetPercent(_root.getBytesLoaded(),_root.getBytesTotal());
   if(meter > gotim * 5)
   {
      meter = gotim * 5;
   }
   if(meter > 100)
   {
      meter = 100;
   }
   _root.LoadMeter._xscale = meter;
   _root.LoadMeter._alpha = 100;
   if(gotim > 20 and meter >= 100)
   {
      sTheme.attachSound("Theme");
      sTheme.start(0,9999);
      delete Loading;
      gotoAndStop(2);
   }
}
stop();
Mouse.hide();
_global.gotim = 0;
_global.keytim = 0;
_global.mouseListener = new Object();
_global.gamHiScore = new Array();
_global.gamHiScoreDate = new Array();
_global.gamDate = new Date();
_global.listEntry;
_global.listID = new Array();
_global.listScore = new Array();
_global.listDate = new Array();
_global.listRanked = new Array();
_global.textMessage = new Array();
_global.textOutline = new Array();
_global.fontDiagnostic = new TextFormat();
fontDiagnostic.font = "Arial";
fontDiagnostic.size = 12;
fontDiagnostic.bold = true;
fontDiagnostic.align = "center";
_global.fontScore = new TextFormat();
fontScore.font = "Comic Book";
fontScore.size = 20;
fontScore.bold = true;
fontScore.align = "center";
_global.fontBig = new TextFormat();
fontBig.font = "Comic Book";
fontBig.size = 36;
fontBig.bold = true;
fontBig.align = "center";
_global.textMonth = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
_global.textVirtue = new Array("Void","Love","Wisdom","Courage","Strength","Discipline","Composure","Generosity","Faith","Compassion","Confidence","Freedom","Purity","Hope","Health","Loyalty","Will");
_global.textVice = new Array("Void","Hate","Ignorance","Cowardice","Weakness","Habit","Anger","Greed","Doubt","Envy","Arrogance","Addiction","Lust","Fear","Disease","Dishonour","Laziness");
_global.sTheme = new Sound();
_global.ProduceSound = function(sound, vol)
{
   sound.setVolume(vol);
   sound.start();
};
_global.DisplayText = function(id, script, textX, textY, font, colour, transparency)
{
   textOutline[id] = _root.createTextField("textOutline" + Dig(id),10000 - id,textX - 250 + 2,textY + 2,500,100);
   textOutline[id].setNewTextFormat(font);
   textOutline[id].embedFonts = true;
   textOutline[id].text = script;
   textOutline[id].textColor = 0;
   textOutline[id]._alpha = transparency;
   textOutline[id].selectable = false;
   textMessage[id] = _root.createTextField("textMessage" + Dig(id),10000 + id,textX - 250,textY,500,100);
   textMessage[id].setNewTextFormat(font);
   textMessage[id].embedFonts = true;
   textMessage[id].text = script;
   textMessage[id].textColor = colour;
   textMessage[id]._alpha = transparency;
   textMessage[id].selectable = false;
};
_global.HideText = function(id)
{
   textMessage[id].removeTextField();
   textOutline[id].removeTextField();
};
_global.DescribeDate = function()
{
   return gamDate.getDate() + " " + textMonth[gamDate.getMonth()] + " " + gamDate.getFullYear();
};
_global.Dig = function(num)
{
   if(num < 10)
   {
      return "0" + num;
   }
   return num;
};
_global.MakePositive = function(num)
{
   if(num < 0)
   {
      return num - num * 2;
   }
   if(num >= 0)
   {
      return num;
   }
};
_global.DisplayFigure = function(num)
{
   minus = 0;
   if(num < 0)
   {
      minus = 1;
      num = MakePositive(num);
   }
   hundreds = 0;
   thousands = 0;
   millions = 0;
   millions = int(num / 1000000);
   if(millions < 0)
   {
      millions = 0;
   }
   thousands = int((num - millions * 1000000) / 1000);
   if(thousands < 0)
   {
      thousands = 0;
   }
   hundreds = int(num - (millions * 1000000 + thousands * 1000));
   if(hundreds < 0)
   {
      hundreds = 0;
   }
   hundredsText = hundreds;
   if(thousands > 0)
   {
      thousandsText = thousands;
   }
   else
   {
      thousandsText = "";
   }
   if(millions > 0)
   {
      millionsText = millions;
   }
   else
   {
      millionsText = "";
   }
   if(thousands > 0 or millions > 0)
   {
      hundredsText = "\'" + hundreds;
   }
   if((thousands > 0 or millions > 0) and hundreds < 100)
   {
      hundredsText = "\'0" + hundreds;
   }
   if((thousands > 0 or millions > 0) and hundreds < 10)
   {
      hundredsText = "\'00" + hundreds;
   }
   if(millions > 0)
   {
      thousandsText = "\'" + thousands;
   }
   if(millions > 0 and thousands < 100)
   {
      thousandsText = "\'0" + thousands;
   }
   if(millions > 0 and thousands < 10)
   {
      thousandsText = "\'00" + thousands;
   }
   if(minus == 0)
   {
      return millionsText + thousandsText + hundredsText;
   }
   if(minus == 1)
   {
      return "-" + millionsText + thousandsText + hundredsText;
   }
};
_global.GetDistance = function(numA, numB)
{
   if(numB >= numA)
   {
      return numB - numA;
   }
   return numA - numB;
};
_global.ReachedAngle = function(startAngle, targetAngle, range)
{
   satisfied = false;
   angler = startAngle;
   count = 1;
   while(count <= range)
   {
      if(angler >= targetAngle - 1 and angler <= targetAngle + 1)
      {
         satisfied = true;
      }
      angler += 1;
      if(angler > 360)
      {
         angler = 0;
      }
      count++;
   }
   angler = startAngle;
   count = 1;
   while(count <= range)
   {
      if(angler >= targetAngle - 1 and angler <= targetAngle + 1)
      {
         satisfied = true;
      }
      angler -= 1;
      if(angler < 0)
      {
         angler = 360;
      }
      count++;
   }
   return satisfied;
};
_global.CleanAngle = function(angle)
{
   while(angle < 0 or angle > 360)
   {
      if(angle > 360)
      {
         angle -= 360;
      }
      if(angle < 0)
      {
         angle += 360;
      }
   }
   return angle;
};
_global.PercentOf = function(num, percent)
{
   return num / 100 * percent;
};
_global.GetPercent = function(numA, numB)
{
   return numA / numB * 100;
};
_global.RandomBetween = function(min, max)
{
   returner = min + random(max + 1 - min);
   return returner;
};
_global.SaveData = function()
{
   dataFile = SharedObject.getLocal("HiScores");
   dataFile.data.HiScore = new Array();
   dataFile.data.HiScoreDate = new Array();
   count = 1;
   while(count <= 10)
   {
      dataFile.data.HiScore[count] = gamHiScore[count];
      dataFile.data.HiScoreDate[count] = gamHiScoreDate[count];
      count++;
   }
   dataFile.flush();
};
_global.LoadData = function()
{
   dataFile = SharedObject.getLocal("HiScores");
   count = 1;
   while(count <= 10)
   {
      gamHiScore[count] = dataFile.data.HiScore[count];
      if(gamHiScore[count] == undefined)
      {
         gamHiScore[count] = 90 + count * 10;
      }
      gamHiScoreDate[count] = dataFile.data.HiScoreDate[count];
      if(gamHiScoreDate[count] == undefined)
      {
         gamHiScoreDate[count] = DescribeDate();
      }
      count++;
   }
};
_global.RankScores = function()
{
   rank = 1;
   while(rank <= 10)
   {
      listRanked[rank] = 0;
      rank++;
   }
   rank = 1;
   while(rank <= 10)
   {
      hi = 9999;
      leader = 1;
      count = 1;
      while(count <= 10)
      {
         if(gamHiScore[count] < hi and listRanked[count] == 0)
         {
            leader = count;
            hi = gamHiScore[count];
         }
         count++;
      }
      listID[rank] = leader;
      listScore[rank] = gamHiScore[leader];
      listDate[rank] = gamHiScoreDate[leader];
      listRanked[leader] = 1;
      rank++;
   }
};
LoadData();
RankScores();
var gotim = 0;
var meter = 0;
onEnterFrame = Loading;
