function TitleScreen()
{
   flashTim += 1;
   if(flashTim > 20)
   {
      flashTim = 0;
   }
   if(flashTim <= 10)
   {
      DisplayText(2,"CLICK TO PLAY!",275,50,fontBig,10092441,100);
   }
   else
   {
      HideText(2);
   }
   DisplayText(1,"Copyright © MDickie.com 2009",328,227,fontDiagnostic,5588053,100);
   gotim += 1;
   mouseListener.onMouseDown = function()
   {
      count = 1;
      while(count <= 2)
      {
         HideText(count);
         count++;
      }
      Cursor.removeMovieClip();
      delete TitleScreen;
      gotoAndStop(3);
   };
   Mouse.addListener(mouseListener);
   Cursor.swapDepths(15000);
   Cursor.onMouseMove = function()
   {
      this._x = _xmouse;
      this._y = _ymouse;
   };
}
stop();
Mouse.hide();
var gotim = 0;
var flashTim = 0;
onEnterFrame = TitleScreen;
