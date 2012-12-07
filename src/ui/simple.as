package ui
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class simple extends Sprite
	{
		private var btnw:Number;
		private var btnh:Number;
		private var downcolor:uint;
		private var upcolor:uint;
		private var overcolor:uint;
		private var lineStly:Boolean;
		
		private var pic:Sprite;
		
		public function simple():void
		{
			
		}
		public function getsimplebtn(str:String,btnw:Number = 50,btnh:Number = 30,downcolor:uint = 0x990066,upcolor:uint = 0xffffff,overcolor:uint = 0x666666,
									 lineStly:Boolean = false, picurl:String = ""):SimpleButton
		{
			if (picurl != ""){
			var myloader:Loader = new Loader();
			myloader.contentLoaderInfo.addEventListener(Event.COMPLETE,picloaded);
			myloader.load(new URLRequest(picurl));
			}
			this.name = str;
			this.btnw = btnw;
			this.btnh = btnh;
			this.downcolor = downcolor;
			this.upcolor = upcolor;
			this.overcolor = overcolor;
			this.lineStly = lineStly;
			var btn:SimpleButton = new SimpleButton();
			btn.downState = downbtn();
			btn.upState = upbtn();
			btn.overState = overbtn();
			btn.hitTestState = hitbtn();
			return btn;
		}
		
		private function picloaded(evt:Event):void
		{
			var myloader:Loader = Loader(evt.target.loader);
			var bitmap:Bitmap = Bitmap(myloader.content);
			this.pic = new Sprite();
			this.pic.addChild(bitmap);
			
		}
		
		private function hitbtn():Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(upcolor);
			sprite.graphics.drawRect(0,0,btnw,btnh);
			sprite.graphics.endFill();
			return sprite;
		}
		private function downbtn():Sprite
		{
			var txt:TextField = txtstr(this.name);
			var sprite:Sprite = DrawSprite(1);
			sprite.addChild(txt);
			return sprite;
		}
		private function upbtn():Sprite
		{
			var txt:TextField = txtstr(this.name);
			var sprite:Sprite = DrawSprite(0);
			sprite.addChild(txt);
			return sprite;
		}
		private function overbtn():Sprite
		{
			var txt:TextField = txtstr(this.name);
			var sprite:Sprite = DrawSprite(2);
			sprite.addChild(txt);
			return sprite;
		}
		private function txtstr(str:String):TextField
		{
			var txt:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.font = "Verdana";
			format.size = 12;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.text = str;
			txt.setTextFormat(format);
			return txt;
		}
		private function DrawSprite(n:int):Sprite
		{
			var sprite:Sprite = new Sprite();
			if (n == 0)
			{
				sprite.graphics.beginFill(upcolor);
			}
			else if (n == 1)
			{
				sprite.graphics.beginFill(downcolor);
			}
			else if (n == 2)
			{
				sprite.graphics.beginFill(overcolor);
			}
			if(lineStly)
			{
				sprite.graphics.lineStyle(1,0x660099);
			}
			sprite.graphics.drawRect(0,0,btnw,btnh);
			sprite.graphics.endFill();
			return sprite;
		}
	}
}