Point = {
    new = function(cls, x,y)
       return {
          x=x;
          y=y;
          add = cls.add; -- note, cls will be a reference to the global table "Point" aka the "class table", so we're taking the below function and sticking it in what you could call this "instance" table.
     }
     end;

    add = function(self, otherPoint)
       self.x = self.x + otherPoint.x
       self.y = self.y + otherPoint.y
    end;
 }