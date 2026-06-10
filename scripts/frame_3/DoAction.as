function MainLoop()
{
   gamState = 0;
   positivity = CountSlices(1);
   if(positivity == 16)
   {
      gamState = 1;
   }
   if(positivity == 0)
   {
      gamState = -1;
   }
   if(gamState != 0)
   {
      endTim += 1;
   }
   else
   {
      endTim = 0;
   }
   randy = RandomBetween(0,1000);
   if(randy <= 1)
   {
      if(wheelDirection > 0)
      {
         wheelDirection = -1;
      }
      else
      {
         wheelDirection = 1;
      }
      wheelSpeed = 1;
      wheelTargetSpeed = 1;
   }
   wheelTargetSpeed = CountSlices(1);
   if(wheelTargetSpeed < 1)
   {
      wheelTargetSpeed = 1;
   }
   if(gamState != 0)
   {
      wheelTargetSpeed = 100;
   }
   if(wheelSpeed < wheelTargetSpeed)
   {
      wheelSpeed += 1;
   }
   if(wheelSpeed > wheelTargetSpeed)
   {
      wheelSpeed -= 1;
   }
   if(wheelDirection > 0)
   {
      wheelAngle += wheelSpeed;
   }
   else
   {
      wheelAngle -= wheelSpeed;
   }
   if(wheelAngle < 0 or wheelAngle > 360)
   {
      wheelAngle = CleanAngle(wheelAngle);
      if(gamState == 0)
      {
         gamLives += 1;
      }
   }
   cyc = 1;
   while(cyc <= 16)
   {
      if(wheelStatus[cyc] == 1)
      {
         wheelVirtue[cyc]._visible = true;
         wheelVice[cyc]._visible = false;
      }
      else
      {
         wheelVirtue[cyc]._visible = false;
         wheelVice[cyc]._visible = true;
      }
      wheelFade[cyc] -= 4;
      if(wheelFade[cyc] < 0)
      {
         wheelFade[cyc] = 0;
      }
      randy = RandomBetween(0,2000);
      if(randy <= 1 and wheelStatus[cyc] > 0 and wheelFade[cyc] == 0 and gamState == 0)
      {
         ProduceSound(sDissolve,100);
         wheelFade[cyc] = 100;
      }
      if(gamState != 0)
      {
         wheelFade[cyc] = 0;
         wheelVirtue[cyc]._alpha = 100;
      }
      if(wheelFade[cyc] > 0 and gamState == 0)
      {
         wheelVirtue[cyc]._visible = true;
         wheelVice[cyc]._visible = true;
         wheelVirtue[cyc]._alpha = wheelFade[cyc];
         if(wheelFade[cyc] < 70)
         {
            wheelStatus[cyc] = -1;
         }
      }
      wheelVirtue[cyc]._rotation = wheelAngle + wheelSliceAngle[cyc];
      wheelVice[cyc]._rotation = wheelAngle + wheelSliceAngle[cyc];
      cyc++;
   }
   if(gamState == 0)
   {
      if(Key.isDown(37) and pRightAnim == 0)
      {
         pRightAnim = 1;
         pRightAnimTim = 0;
      }
      if(Key.isDown(39) and pLeftAnim == 0)
      {
         pLeftAnim = 1;
         pLeftAnimTim = 0;
      }
   }
   mouseListener.onMouseDown = function()
   {
      if(gamState == 0)
      {
         if(_xmouse < 265 and pRightAnim == 0)
         {
            pRightAnim = 1;
            pRightAnimTim = 0;
         }
         if(_xmouse > 285 and pLeftAnim == 0)
         {
            pLeftAnim = 1;
            pLeftAnimTim = 0;
         }
      }
   };
   Mouse.addListener(mouseListener);
   pAnimTim += 1;
   pLeftAnimTim += 1;
   pRightAnimTim += 1;
   if(pAnim == 0)
   {
      if(pAnimTim <= pBreatheSpeed / 2)
      {
         pAnimFrame = 1;
      }
      else
      {
         pAnimFrame = 2;
      }
      if(pAnimTim > pBreatheSpeed)
      {
         pAnimTim = 0;
      }
      if(gamState == 1)
      {
         pAnim = 1;
         pAnimTim = 0;
      }
   }
   if(pAnim == 1)
   {
      if(pAnimTim <= 2)
      {
         pAnimFrame = 9;
      }
      if(pAnimTim >= 3 and pAnimTim <= 4)
      {
         pAnimFrame = 11;
      }
      if(pAnimTim >= 5)
      {
         pAnim = 2;
         pAnimTim = 0;
      }
   }
   if(pAnim == 2)
   {
      if(pAnimTim <= pBreatheSpeed / 2)
      {
         pAnimFrame = 12;
      }
      else
      {
         pAnimFrame = 12;
      }
      if(pAnimTim > pBreatheSpeed)
      {
         pAnimTim = 0;
      }
   }
   if(pLeftAnim == 1)
   {
      if(pLeftAnimTim <= 1)
      {
         pLeftHand = 1;
      }
      if(pLeftAnimTim >= 2 and pLeftAnimTim <= 4)
      {
         pLeftHand = 2;
      }
      if(pLeftAnimTim == 2)
      {
         ToggleSlice(FindSlice(wheelAngle,1));
      }
      if(pLeftAnimTim >= 5 and pLeftAnimTim <= 6)
      {
         pLeftHand = 1;
      }
      if(pLeftAnimTim >= 7)
      {
         pLeftHand = 0;
         pLeftAnim = 0;
      }
   }
   if(pRightAnim == 1)
   {
      if(pRightAnimTim <= 1)
      {
         pRightHand = 1;
      }
      if(pRightAnimTim >= 2 and pRightAnimTim <= 4)
      {
         pRightHand = 2;
      }
      if(pRightAnimTim == 2)
      {
         ToggleSlice(FindSlice(wheelAngle,-1));
      }
      if(pRightAnimTim >= 5 and pRightAnimTim <= 6)
      {
         pRightHand = 1;
      }
      if(pRightAnimTim >= 7)
      {
         pRightHand = 0;
         pRightAnim = 0;
      }
   }
   if(pLeftHand == 1 and pRightHand == 0)
   {
      pAnimFrame = 3;
   }
   if(pLeftHand == 2 and pRightHand == 0)
   {
      pAnimFrame = 4;
   }
   if(pLeftHand == 2 and pRightHand == 1)
   {
      pAnimFrame = 5;
   }
   if(pLeftHand == 0 and pRightHand == 1)
   {
      pAnimFrame = 6;
   }
   if(pLeftHand == 0 and pRightHand == 2)
   {
      pAnimFrame = 7;
   }
   if(pLeftHand == 1 and pRightHand == 2)
   {
      pAnimFrame = 8;
   }
   if(pLeftHand == 1 and pRightHand == 1)
   {
      pAnimFrame = 9;
   }
   if(pLeftHand == 2 and pRightHand == 2)
   {
      pAnimFrame = 10;
   }
   _root.Player.gotoAndStop(pAnimFrame);
   randy = RandomBetween(0,25);
   if(randy <= 1)
   {
      pHeadTY = pHeadSY + RandomBetween(-1,1);
   }
   if(randy == 1)
   {
      pHeadTX = pHeadSX + RandomBetween(-1,1);
   }
   if(randy <= 1)
   {
      pHeadTargetAngle = RandomBetween(-5,5);
   }
   if(pHeadX < pHeadTX)
   {
      pHeadX += 0.25;
   }
   if(pHeadX > pHeadTX)
   {
      pHeadX -= 0.25;
   }
   if(pHeadY < pHeadTY)
   {
      pHeadY += 0.25;
   }
   if(pHeadY > pHeadTY)
   {
      pHeadY -= 0.25;
   }
   if(pHeadAngle < pHeadTargetAngle)
   {
      pHeadAngle += 0.5;
   }
   if(pHeadAngle > pHeadTargetAngle)
   {
      pHeadAngle -= 0.5;
   }
   _root.Head._x = pHeadX;
   _root.Head._y = pHeadY;
   if(pAnimFrame == 2)
   {
      _root.Head._y = pHeadY + 2;
   }
   if(pAnimFrame > 10)
   {
      _root.Head._y = pHeadY - 2;
   }
   _root.Head._rotation = pHeadAngle;
   positivity = GetPercent(CountSlices(1),16);
   pExpression = 5;
   if(positivity >= 35)
   {
      pExpression = 4;
   }
   if(positivity >= 55)
   {
      pExpression = 3;
   }
   if(positivity >= 75)
   {
      pExpression = 2;
   }
   if(positivity >= 90)
   {
      pExpression = 1;
   }
   _root.Head.gotoAndStop(pExpression);
   DisplayText(1,gamLives,50,20,fontBig,14540287,100);
   DisplayText(2,"Lifetimes",50,58,fontDiagnostic,16751103,100);
   keytim -= 1;
   if(keytim < 0)
   {
      keytim = 0;
   }
   gotim += 1;
   if(Key.isDown(27) or endTim > 125)
   {
      cyc = 1;
      while(cyc <= 16)
      {
         wheelVirtue[cyc].removeMovieClip();
         wheelVice[cyc].removeMovieClip();
         cyc++;
      }
      _root.Player.removeMovieClip();
      _root.Head.removeMovieClip();
      count = 1;
      while(count <= 2)
      {
         HideText(count);
         count++;
      }
      delete MainLoop;
      if(gamState != 0)
      {
         gotoAndStop(4);
      }
      else
      {
         sTheme.start(0,9999);
         gotoAndStop(2);
      }
   }
}
function FindSlice(angle, hand)
{
   slice = 0;
   cyc = 1;
   while(cyc <= 16)
   {
      if(hand < 0)
      {
         coreAngle = 360 - cyc * 22.5;
      }
      if(hand > 0)
      {
         coreAngle = 197.5 - cyc * 22.5;
      }
      coreAngle = CleanAngle(coreAngle);
      if(ReachedAngle(angle,coreAngle,11) == true)
      {
         slice = cyc;
      }
      cyc++;
   }
   return slice;
}
function ToggleSlice(slice)
{
   if(wheelFade[slice] > 0)
   {
      wheelStatus[slice] = 1;
      wheelFade[slice] = 0;
   }
   else if(wheelStatus[slice] > 0)
   {
      wheelStatus[slice] = -1;
   }
   else
   {
      wheelStatus[slice] = 1;
   }
   wheelVirtue[slice]._alpha = 100;
   if(wheelStatus[slice] > 0)
   {
      ProduceSound(sVirtue,100);
   }
   else
   {
      ProduceSound(sVice,100);
   }
   if(CountSlices(1) == 16 or CountSlices(-1) == 16)
   {
      ProduceSound(sMoksha,100);
      sTheme.start(0,9999);
   }
}
function CountSlices(style)
{
   count = 0;
   cyc = 1;
   while(cyc <= 16)
   {
      if(wheelStatus[cyc] == style)
      {
         count += 1;
      }
      cyc++;
   }
   return count;
}
stop();
Mouse.hide();
sTheme.stop();
var gamState = 0;
var gamLives = 0;
var wheelAngle = 0;
var wheelDirection = 1;
var wheelSpeed = 1;
var wheelTargetSpeed = 10;
var wheelVirtue = new Array();
var wheelVice = new Array();
var wheelStatus = new Array();
var wheelSliceAngle = new Array();
var wheelFade = new Array();
var pAnim = 0;
var pAnimTim = 0;
var pLeftAnim = 0;
var pLeftAnimTim = 0;
var pLeftHand = 0;
var pRightAnim = 0;
var pRightAnimTim = 0;
var pRightHand = 0;
var pAnimFrame = 0;
var pBreatheSpeed = 20;
var pExpression = 0;
var pHeadX = 0;
var pHeadSX = 0;
var pHeadTX = 0;
var pHeadY = 0;
var pHeadSY = 0;
var pHeadTY = 0;
var pHeadAngle = 0;
var pHeadTargetAngle = 0;
_global.sVirtue = new Sound();
sVirtue.attachSound("Virtue");
_global.sVice = new Sound();
sVice.attachSound("Vice");
_global.sDissolve = new Sound();
sDissolve.attachSound("Dissolve");
_global.sMoksha = new Sound();
sMoksha.attachSound("Moksha");
wheelAngle = RandomBetween(1,360);
cyc = 1;
while(cyc <= 16)
{
   wheelVice[cyc] = attachMovie(textVice[cyc],"Vice" + cyc,cyc);
   wheelVirtue[cyc] = attachMovie(textVirtue[cyc],"Virtue" + cyc,16 + cyc);
   wheelVirtue[cyc]._x = 275;
   wheelVirtue[cyc]._y = 200;
   wheelVice[cyc]._x = 275;
   wheelVice[cyc]._y = 200;
   wheelSliceAngle[cyc] = (cyc - 1) * 22.5;
   wheelVirtue[cyc]._rotation = wheelAngle + wheelSliceAngle[cyc];
   wheelVice[cyc]._rotation = wheelAngle + wheelSliceAngle[cyc];
   wheelStatus[cyc] = -1;
   wheelFade[cyc] = 0;
   cyc++;
}
wheelStatus[RandomBetween(1,16)] = 1;
wheelStatus[RandomBetween(1,16)] = 1;
_root.Player.swapDepths(100);
_root.Head.swapDepths(101);
pHeadSX = _root.Head._x;
pHeadX = pHeadSX;
pHeadTX = pHeadX;
pHeadSY = _root.Head._y;
pHeadY = pHeadSY;
pHeadTY = pHeadY;
pHeadAngle = 0;
pHeadTargetAngle = 0;
var gotim = 0;
var keytim = 0;
var endTim = 0;
onEnterFrame = MainLoop;
