package ui
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class FriendItemRender extends FriendItemRenderer
	{
		private var bitmap:Bitmap = new Bitmap();
		
		public function FriendItemRender(grade:String, BitmapUrl:String, userName:String)
		{
			super();
			this.level.text = grade;
			this.userName.text = userName;
			
			loadPic(BitmapUrl);
		}
		
		private function loadPic(url:String):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, piccomplete);
			loader.load(new URLRequest(url));
		}
		
		private function piccomplete(evt:Event):void
		{
			var loader:Loader = Loader(evt.target.loader);
			bitmap = Bitmap(loader.content);
			bitmap.x = 36;
			bitmap.y = 2.75;
			bitmap.width = 35;
			bitmap.height = 35;
			this.addChild(bitmap);
		}
		
		public function setGrade(grade:String):void
		{
			this.level.text = grade;
		}
		
		public function setUserName(userName:String):void
		{
			this.userName.text = userName;
		}
		
		public function changeHeader(headImageUrl:String):void
		{
			this.removeChild(bitmap);
			loadPic(headImageUrl);
		}
	}
}