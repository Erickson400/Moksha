function HiScoreTable()
{
   keytim -= 1;
   if(keytim < 0)
   {
      keytim = 0;
   }
   if(Key.isDown(8) and keytim == 0)
   {
      count = 1;
      while(count <= 10)
      {
         gamHiScore[count] = 90 + count * 10;
         gamHiScoreDate[count] = DescribeDate();
         count++;
      }
      SaveData();
      RankScores();
      keytim = 20;
   }
   listY = 24;
   DisplayText(40,"Hi Scores:",275,listY,fontBig,16711680,100);
   listY = 82;
   rank = 1;
   while(rank <= 10)
   {
      if(listID[rank] == listEntry)
      {
         colour = 16772608;
      }
      else
      {
         colour = 16772761;
      }
      DisplayText(rank,rank + ".",95,listY,fontScore,colour,100);
      if(listID[rank] == listEntry)
      {
         colour = 16772608;
      }
      else
      {
         colour = 16777215;
      }
      DisplayText(rank + 10,listScore[rank] + " Lifetimes",190,listY,fontScore,colour,100);
      if(listID[rank] == listEntry)
      {
         colour = 16772608;
      }
      else
      {
         colour = 14540287;
      }
      DisplayText(rank + 20,listDate[rank],380,listY,fontScore,colour,100);
      listY += 26;
      rank++;
   }
   flashTim += 1;
   if(flashTim > 20)
   {
      flashTim = 0;
   }
   if(flashTim <= 10)
   {
      DisplayText(41,">>> CLICK TO PROCEED >>>",275,360,fontScore,10092441,100);
   }
   else
   {
      HideText(41);
   }
   gotim += 1;
   mouseListener.onMouseDown = function()
   {
      count = 1;
      while(count <= 50)
      {
         textMessage[count].removeTextField();
         textOutline[count].removeTextField();
         count++;
      }
      delete HiScoreTable;
      gotoAndStop(2);
   };
   Mouse.addListener(mouseListener);
   Cursor.swapDepths(16000);
   Cursor.onMouseMove = function()
   {
      this._x = _xmouse;
      this._y = _ymouse;
   };
}
stop();
Mouse.hide();
if(gamState == 1)
{
   hi = 0;
   lowest = 10;
   rank = 1;
   while(rank <= 10)
   {
      if(gamHiScore[rank] > hi)
      {
         lowest = rank;
         hi = gamHiScore[rank];
      }
      rank++;
   }
   cyc = 1;
   listEntry = 0;
   if(gamLives < gamHiScore[lowest])
   {
      listEntry = lowest;
      gamHiScore[listEntry] = gamLives;
      gamHiScoreDate[listEntry] = DescribeDate();
   }
   SaveData();
}
RankScores();
var gotim = 0;
var flashTim = 0;
onEnterFrame = HiScoreTable;
