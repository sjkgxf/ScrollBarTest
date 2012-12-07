 package ui
 {
     import flash.display.Sprite;
     public class ListenManager extends Sprite
     {
         public function ListenManager()
         {
 
         }
         public function fcn_add(obj:*,_type:String,fcn:Function):void
         {
			obj.addEventListener(_type,fcn);
         }
         public function fcn_del(obj:*,_type:String,fcn:Function):void
         {
			 obj.removeEventListener(_type,fcn);
         }
     }
 }