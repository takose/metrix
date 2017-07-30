# class matrix{
#   float [][] c;
#   int n,m;// float c[n][m]
#   matrix(){
#     c=null;
#     n=m=0;
#   }
#   matrix(float [][]_c ,int _n, int _m){
#     n=_n;
#     m=_m;
#     c=new float[n][m];
#     for(int x=0; x<m; x++){
#       for(int y=0; y<n; y++){
#         c[y][x] = _c[y][x];
#       }
#     }
#   }
#   String toString(){
#     String ret = "";
#       for(int y=0; y<n; y++){
#         ret += "[";
#         for(int x=0; x<m; x++){
#           ret += c[y][x];
#           if(x<m-1) ret += ",";
#         }
#         ret += "]\r\n";
#       }
#     return ret;
#   }
# }
class MetrixService
  attr_reader :c, :n, :m
  attr_accessor :error
  def initialize(_c)
    @c = _c
    if _c == []
      @n = 0
      @m = 0
    else
      @n = @c.count
      @m = @c.first.count
    end
    @error = nil
  end

  def self.sum(a, b)
  # if(a.n!=b.n || a.m!=b.m) return new matrix();
  #   int n = a.n;
  #   int m = b.m;
  #   float[][] _c=new float [n][m];
  #   for(int x=0; x<m; x++){
  #     for(int y=0; y<n; y++){
  #       _c[y][x] = a.c[y][x] + b.c[y][x];
  #     }
  #   }
  #     return new matrix(_c,n,m);
    n = a.n
    m = b.m
    _c = []

    if a.n != b.n || a.m != b.m
      @error = '行列のサイズが正しくありません'
      c = MetrixService.new(_c)
      c.error = @error
      return c
    end

    m.times do |x|
      _ = []
      n.times do |y|
        _ << a.c[y][x] + b.c[y][x]
      end
      _c << _
    end
    MetrixService.new(_c)
  end

  def self.prod(a, b)
  # if(a.m!=b.n) return new matrix();
  #   int n = a.n;
  #   int m = a.m;
  #   int k = a.m;
  #   float[][] _c=new float [n][m];
  #   for(int x=0; x<m; x++){
  #     for(int y=0; y<n; y++){
  #       _c[y][x] = 0;
  #       for(int z=0; z<k; z++){
  #         _c[y][x] += a.c[y][z] * b.c[z][x];
  #       }
  #     }
  #   }
  #     return new matrix(_c,n,m);
    n = a.n
    m = b.m
    k = a.m
    _c = []

    if a.m != b.n
      @error = '行列のサイズが正しくありません'
      c = MetrixService.new(_c)
      c.error = @error
      return c
    end

    m.times do |x|
      _ = []
      n.times do |y|
        __ = 0
        k.times do |z|
          __ += a.c[y][z] * b.c[z][x]
        end
        _ << __
      end
      _c << _
    end
    MetrixService.new(_c)
  end
end
