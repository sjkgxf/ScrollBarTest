package ui
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ListItem extends MovieClip
	{
		private var grade:String;
		private var headImage:Sprite;
		private var playerName:String;
		
		public function ListItem(firstText:String, BitmapUrl:String, secondTest:String, width:Number, height:Number):void
		{
			super();
			this.grade = firstText;
			this.playerName = secondTest;
			this.headImage = new Sprite();
			
			this.graphics.beginFill(0x990099);
			this.graphics.drawRect(0,0,width,height);
			this.graphics.endFill();
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, piccomplete);
			loader.load(new URLRequest(BitmapUrl));
		}
		
		private function piccomplete(evt:Event):void
		{
			var loader:Loader = Loader(evt.target.loader);
			var bitmap:Bitmap = Bitmap(loader.content);
			headImage.addChild(bitmap);
			bitmap.x = 0;
			bitmap.y = 0;
			bitmap.width = 50;
			bitmap.height = 50;
			
			var txt1:TextField = txtstr(this.grade);
			var txt2:TextField = txtstr(this.playerName);
			this.addChild(txt1);
			this.addChild(headImage);	
			this.addChild(txt2);
			txt1.x = 0;
			headImage.x = 50;
			txt2.x = 100;
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
	}
}