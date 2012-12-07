package
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.osmf.layout.ScaleMode;
	
	import ui.FriendItemRender;
	import ui.GroupItemRender;
	import ui.ListItem;
	import ui.Scrollbar;
	import ui.simple;
	
	import vo.FriendDataElement;
	
	
	

	public class MyList extends Sprite
	{
		public static const  FRIEND_ITEM:String = "friendItem";
		public static const  NEWS_TIEM:String = "newsItem";
		public static const  GROUP_ITEM:String = "groupItem";
		public static const  CHAR_ITEM:String = "chatItem";
		
		private var backbox:Sprite = new Sprite();
		private var sprite:Sprite = new Sprite();
		private var scrollcont:Sprite = new Sprite();
		private var itemCount:int = 0;
		private var j:int = -1;
		private var num:int;
		public var bar:MovieClip;//滑块
		public var up:MovieClip;//向上按钮
		public var down:MovieClip;//向下按钮
		public var bg:MovieClip;//滑槽
		private var listscroll:Scrollbar = new Scrollbar();
		
		private var listWidth:Number;
		private var listHeight:Number;
		private var interHeight:Number;
		
		private var dataProvider:Array = new Array();
		
		private var preItem:FriendItemRender;
		
		
		public function MyList(itemtype:String = "friendItem", width:Number = 200, height:Number = 300,interheight:Number = 0, _data:Array = null)
		{
			this.listWidth = width;
			this.listHeight = height;
			this.interHeight = interheight;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			/*var _data:Vector.<FriendDataElement> = new Vector.< FriendDataElement>;
			_data.push(new FriendDataElement("1","assets/bar.png","我去1"));
			_data.push(new FriendDataElement("2","assets/up.png","我去2"));
			_data.push(new FriendDataElement("3","assets/down.png","我去3"));
			_data.push(new FriendDataElement("4","assets/bg.png","我去4"));
			_data.push(new FriendDataElement("5","assets/bar.png","我去5"));
			_data.push(new FriendDataElement("6","assets/bar.png","我去6"));*/
			
			_data = new Array();
			_data.push(new FriendDataElement("1","assets/bar.png","我去1"));
			_data.push(new FriendDataElement("2","assets/up.png","我去2"));
			_data.push(new FriendDataElement("3","assets/down.png","我去3"));
			_data.push(new FriendDataElement("4","assets/bg.png","我去4"));
			_data.push(new FriendDataElement("5","assets/bar.png","我去5"));
			_data.push(new FriendDataElement("6","assets/bar.png","我去6"));

			dataProvider = _data;
		
			init(itemtype);
		}
		
		private function init(itemtype:String):void
		{
			switch(itemtype){
				case FRIEND_ITEM:
					uiInit();
					friendDataInit();
					break;
				case NEWS_TIEM:
					break;
				case GROUP_ITEM:
					uiInit();
					groupDataInit();
					break;
				case CHAR_ITEM:
					break;
			}
			
			var btn:simple = new simple();
			var Test_btn:SimpleButton;
			Test_btn = btn.getsimplebtn("Add Item",60,30,0xff00cc,0xcc00cc,0x9900cc);
			Test_btn.x = 65;
			Test_btn.y = backbox.height + 15;
			this.addChild(Test_btn);
			Test_btn.addEventListener(MouseEvent.CLICK,Testbtn_click);
		}

		private function uiInit():void
		{
			
			var spmask:Sprite = new Sprite();
			
			bar = new ThumbMC();
			bg = new TrackMC();
			up = new UpBtn();
			down = new DownBtn();
			backbox.graphics.beginFill(0xAFD4E7);
			backbox.graphics.drawRect(0,0,listWidth,listHeight);
			backbox.graphics.endFill();
			backbox.y = 10;
			addChild(backbox);
			scrollcont.x = backbox.width - 14;
			scrollcont.y = backbox.y;
			addChild(scrollcont);
			
			down.y = scrollcont.y;
			scrollcont.addChild(down);
			scrollcont.addChild(bg);
			scrollcont.addChild(up);
			scrollcont.addChild(bar);
			
			spmask.graphics.beginFill(0x000000);
			spmask.graphics.drawRect(0,0,backbox.width,backbox.height);
			spmask.graphics.endFill();
			backbox.addChild(sprite);
			backbox.addChild(spmask);
		
			listscroll.displayobject = this.stage;
			listscroll.obj = sprite;
			listscroll.scrollmask = spmask;
			listscroll.textspeed = 20;
			listscroll.Scroll = scrollcont;
			listscroll.scrollheight = backbox.height - 15;
			listscroll.up = up;
			listscroll.down = down;
			listscroll.bg = bg;
			listscroll.bar = bar;
			listscroll.num = itemCount;
			listscroll.init();
			
		}
		private function Testbtn_click(evt:MouseEvent):void
		{
			addfriendItem();
		}
		
		private function addfriendItem():void
		{
			var str:String = (itemCount+1).toString();
			var item:FriendItemRender = new FriendItemRender(str,"assets/up.png","我去2");
			//var item:GroupItemRender = new GroupItemRender(str);
			item.x = 1;
			item.y = itemCount * (item.height + interHeight / 2);
			sprite.addChild(item);
			listscroll.update(itemCount);
			itemCount++;
		}
		
		private function friendDataInit():void
		{
			for each (var e:FriendDataElement in dataProvider)
			{
				var item:FriendItemRender = new FriendItemRender(e.grade,e.headImage,e.username);
				item.x = 1;
				item.y = itemCount * (item.height + interHeight / 2);
				sprite.addChild(item);
				item.setUserName(item.height.toString());
				listscroll.update(itemCount);
				itemCount++;
			}
		}
		
		private function groupDataInit():void
		{
			for each (var e:FriendDataElement in dataProvider)
			{
				var item:GroupItemRender = new GroupItemRender(e.username);
				item.x = 1;
				item.y = itemCount * (item.height + interHeight / 2);
				sprite.addChild(item);
				item.setGroupName(item.height.toString());
				listscroll.update(itemCount);
				itemCount++;
			}
		}
	}
}