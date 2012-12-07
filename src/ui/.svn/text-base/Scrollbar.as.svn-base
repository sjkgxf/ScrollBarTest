package ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import ui.ListenManager;
	
	public class Scrollbar extends Sprite
	{
		public var obj:Sprite;//需进行滚动的对象
		public var scrollmask:Sprite;//遮罩对象
		public var scrollheight:Number;//滚动条高度
		public var scrolltextnum:int;//文本显示行数
		public var textspeed:int;//文本滚动速度（行/像素）
		public var Scroll:Sprite;//自定义滚动条对象
		public var bar:MovieClip;//滑块
		public var up:MovieClip;//向上按钮
		public var down:MovieClip;//向下按钮
		public var bg:MovieClip;//滑槽
		public var displayobject:*;//接受stage，必须传入
		public var num:int;//计算滑块高度所用
		
		private var bars:Number;//滑块可滑动距离
		private var rect:Rectangle;//滑块可拖动范围
		private var i:int = 0;
		private var n:Number;
		private var listenmanager:ListenManager = new ListenManager();///监听管理器
		////构造器函数/////
		public function Scrollbar():void
		{
		}
		/////初始化函数/////
		public function init():void
		{
			
			if (checkhide())
			{
				addEventListeners();
			}
			else
			{
				bar.visible = false;
			}
			setxy();
		}
		///判断是否显示滚动条等///
		private function checkhide():Boolean
		{
			if (Scroll != null)
			{
				if (obj.height <= scrollmask.height)
				{
					return false;
				}
				return true;
			}
			return false;
		}
		///设置滚动条高度，对象遮罩等////
		private function setxy():void
		{
			up.y = 0;
			bg.x = 2;
			bg.y = up.height;
			bar.x = 0.38;
			bar.y = bg.y;
			if (bar.height >= 10)
			{
				n = (obj.height - scrollmask.height)/(num+20);
				bar.height = scrollmask.height - (obj.height - scrollmask.height)/n * 5;
			}
			bg.height = scrollheight;
			down.y = bg.y + bg.height;
			bars = bg.height - bar.height;
			obj.mask = scrollmask;
			rect = new Rectangle(bar.x,bg.y,0,bg.height - bar.height);
		}
		///当被滚动对象更新时，而需要改变滚动条状态，调用此方法///
		public function update(num:int):void
		{
			if (checkhide())
			{
				i++;
				if (bar.height >= 40)
				{
					n = (obj.height - scrollmask.height)/(num+20);
					bar.height = scrollmask.height - (obj.height - scrollmask.height)/n * 5;
				}
				bar.y = bg.y + bg.height - bar.height;
				bar.y +=  bars * textspeed /(obj.height - scrollmask.height);
				obj.y = scrollmask.y - obj.height + scrollmask.height;
				objrun(textspeed);
				updatebar();
				bars = bg.height - bar.height;
				rect = new Rectangle(bar.x,bg.y,0,bg.height - bar.height);
				if (i == 1)
				{
					bar.visible = true;
					addEventListeners();
				}
			}
		}
		///为滚动条添加监听事件////
		private function addEventListeners():void
		{
			listenmanager.fcn_add(bar,MouseEvent.MOUSE_DOWN,barclick);
			listenmanager.fcn_add(bar,MouseEvent.MOUSE_UP,barup);
			listenmanager.fcn_add(displayobject,MouseEvent.MOUSE_UP,barup);
			listenmanager.fcn_add(up,MouseEvent.MOUSE_DOWN,upclick);
			listenmanager.fcn_add(down,MouseEvent.MOUSE_DOWN,downclick);
			listenmanager.fcn_add(Scroll,MouseEvent.MOUSE_WHEEL,mousewheel);
			listenmanager.fcn_add(obj,MouseEvent.MOUSE_WHEEL,mousewheel);
		}
		///鼠标点击滑块方法///;
		private function barclick(evt:MouseEvent):void
		{
			bar.startDrag(false,rect);
			listenmanager.fcn_add(bar,Event.ENTER_FRAME,bar_enter_frame);
		}
		///鼠标点击滑块释放方法///;
		private function barup(evt:MouseEvent):void
		{
			bar.stopDrag();
			delevent();
		}
		///鼠标点击向上按钮方法///
		private function upclick(evt:MouseEvent):void
		{	
			listenmanager.fcn_add(up, Event.ENTER_FRAME, up_enter_frame);
			listenmanager.fcn_add(up, MouseEvent.MOUSE_UP, upmouseup);
			listenmanager.fcn_add(up, MouseEvent.MOUSE_OUT, upmouseup);
		}
		private function upbar():void
		{
			if (checkbar())
			{
				bar.y -= bars * textspeed /(obj.height-scrollmask.height);//滑块移动的距离=滚动对象滚动的像素*滑块可移动的总距离/(被滚动对象的高度-遮罩的高度（即显示范围的高度))
				objrun(0-textspeed);
				//调用方法移动对象;
				updatebar();//校正滑块位置
			}
		}
		///鼠标点击向下按钮方法///
		private function downclick(evt:MouseEvent):void
		{
			listenmanager.fcn_add(down, Event.ENTER_FRAME, down_enter_frame);
			listenmanager.fcn_add(down, MouseEvent.MOUSE_UP, downmouseup);
			listenmanager.fcn_add(down, MouseEvent.MOUSE_OUT, downmouseup);
		}
		
		private function downbar():void
		{
			if (checkbar())
			{
				bar.y +=  bars * textspeed /(obj.height - scrollmask.height);
				objrun(textspeed);
				updatebar();
			}
		}
		
		private function upmouseup(evt:MouseEvent):void
		{
			listenmanager.fcn_del(up, Event.ENTER_FRAME, up_enter_frame);
		}
		
		private function downmouseup(evt:MouseEvent):void
		{
			listenmanager.fcn_del(down, Event.ENTER_FRAME, down_enter_frame);
		}
		
		private function up_enter_frame(evt:Event):void
		{
			upbar();
		}
		
		private function down_enter_frame(evt:Event):void
		{
			downbar();
		}
		///鼠标滑轮事件///
		private function mousewheel(evt:MouseEvent):void
		{
			if (evt.delta > 0)
			{
				if (checkbar())
				{
					bar.y -=  bars * textspeed /(obj.height - scrollmask.height);
					objrun(-textspeed);
					updatebar();
				}
			}
			else
			{
				if (checkbar())
				{
					bar.y +=  bars * textspeed /(obj.height - scrollmask.height);
					objrun(textspeed);
					updatebar();
				}
			}
		}
		private function bar_enter_frame(evt:Event):void
		{
			obj.y = scrollmask.y - (bar.y - bg.y)*(obj.height - scrollmask.height)/bars;
			if (obj.y > scrollmask.y)
			{
				obj.y = scrollmask.y;
			}
			else if (obj.y < (scrollmask.y - obj.height + scrollmask.height))
			{
				obj.y = scrollmask.y - obj.height + scrollmask.height;
			}
		}
		private function objrun(i:Number):void
		{
			obj.y -=  i;
			if (obj.y > scrollmask.y)
			{
				obj.y = scrollmask.y;
			}
			else if (obj.y < (scrollmask.y - obj.height + scrollmask.height))
			{
				obj.y = scrollmask.y - obj.height + scrollmask.height;
			}
		}
		private function checkbar():Boolean
		{
			if (bar.y >= bg.y && bar.y <= (bars + bg.y))
			{
				return true;
			}
			return false;
		}
		///删除卸载事件侦听///
		private function updatebar():void
		{
			if (bar.y < bg.y)
			{
				bar.y = bg.y;
			}
			else if (bar.y >(bg.y + bg.height - bar.height))
			{
				bar.y = bg.y + bg.height - bar.height;
			}
		}
		private function delevent():void
		{
			listenmanager.fcn_del(bar,Event.ENTER_FRAME,bar_enter_frame);
		}
	}
}