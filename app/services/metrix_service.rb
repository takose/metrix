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

  def tr
    # float tr(){
    #   if(n!=m) return 0;
    #     int trace=0;
    #     for(int x=0; x<n; x++){
    #       trace += c[x][x];
    #     }
    #       return trace;
    # }

    if m != n
      @error = '行列のサイズが正しくありません'
      c = MetrixService.new(_c)
      c.error = @error
      return c
    end

    result = 0
    m.times do |i|
      result += @c[i][i]
    end
    result
  end

  def det
    # float det(){
    #   if(n==2 && m==2){
    #     return c[0][0] * c[1][1] - c[1][0] * c[0][1];
    #   } else if(n==3 && m==3){
    #     float d = c[0][0] * c[1][1] * c[2][2] +
    #     c[0][1] * c[1][2] * c[2][0] +
    #     c[0][2] * c[1][0] * c[2][1] -
    #     c[0][0] * c[1][2] * c[2][1] -
    #     c[0][1] * c[1][0] * c[2][2] -
    #     c[0][2] * c[1][1] * c[2][0];
    #     return d;
    #   } else {
    #     return 0;
    #   }
    # }
    if n == 2 && m == 2
      c[0][0] * c[1][1] - c[1][0] * c[0][1]
    elsif n == 3 && m ==3
      c[0][0] * c[1][1] * c[2][2] +
      c[0][1] * c[1][2] * c[2][0] +
      c[0][2] * c[1][0] * c[2][1] -
      c[0][0] * c[1][2] * c[2][1] -
      c[0][1] * c[1][0] * c[2][2] -
      c[0][2] * c[1][1] * c[2][0]
    elsif n == m && n > 3
      @error = '行列のサイズが大きすぎます'
      c = MetrixService.new(_c)
      c.error = @error
      return c
    else
      @error = '行列のサイズが正しくありません'
      c = MetrixService.new(_c)
      c.error = @error
      return c
    end
  end

  def build_string
    # String toString(){
    #   String ret = "";
    #   for(int y=0; y<n; y++){
    #     ret += "[";
    #     for(int x=0; x<m; x++){
    #       ret += c[y][x];
    #       if(x<m-1) ret += ",";
    #     }
    #       ret += "]\r\n";
    #   }
    #     return ret;
    # }
    _ = []
    c.each do |_c|
      _ << _c.join(' ')
    end
    _.join("\r\n")
  end
end
