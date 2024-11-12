CREATE DATABASE QuanLyTraSua
USE QuanLyTraSua;

CREATE TABLE LOAISANPHAM
(
	MALOAI INT PRIMARY KEY IDENTITY(1,1),
	TENLOAI NVARCHAR(500)
)

CREATE TABLE SANPHAM
(
	MASP INT PRIMARY KEY IDENTITY(1,1),
	TENSP NVARCHAR(100),
	MOTA NVARCHAR(500),
	GIA FLOAT,
	HINHANH CHAR(100),
	MALOAI INT,
	FOREIGN KEY (MALOAI) REFERENCES LOAISANPHAM(MALOAI)
)

CREATE TABLE KICHTHUOC
(	
	MAKICHTHUOC INT IDENTITY(1,1) PRIMARY KEY,
	TENKICHTHUOC NVARCHAR(100)
)

CREATE TABLE SANPHAMKICHTHUOC
(
    MASP INT,
    MAKICHTHUOC INT,
    GIASIZE FLOAT, -- Giá cho kích thước cụ thể
    PRIMARY KEY (MASP, MAKICHTHUOC),
    FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP),
    FOREIGN KEY (MAKICHTHUOC) REFERENCES KICHTHUOC(MAKICHTHUOC)
);
CREATE TABLE VAITRO
(
	MAVAITRO INT PRIMARY KEY IDENTITY(1,1),
	TENVAITRO NVARCHAR(50),
)
CREATE TABLE NGUOIDUNG
(
	MAND INT PRIMARY KEY IDENTITY(1,1),
	TENDANGNHAP NVARCHAR(100),
	MATKHAU CHAR(100),
	HINHANH CHAR(100),
	SDT CHAR(10),
	EMAIL CHAR(100),
	NGSINH DATE,
	DIACHI NVARCHAR(100),
	MAVAITRO INT,
	FOREIGN KEY (MAVAITRO) REFERENCES VAITRO (MAVAITRO),
)

CREATE TABLE KHACHHANG
(
	MAKH INT PRIMARY KEY IDENTITY(1,1),
	MAND INT,
	TENKH NVARCHAR (100),
	FOREIGN KEY (MAND) REFERENCES NGUOIDUNG(MAND)
)
CREATE TABLE KHUYENMAI 
(
	MAKM INT PRIMARY KEY IDENTITY(1,1),
	MOTA NVARCHAR(100),
	PHANTRAMGIAM FLOAT,
	NGAYBATDAU DATE,
	NGAYKETTHUC DATE
)
CREATE TABLE DONHANG
(
	MADH INT PRIMARY KEY IDENTITY(1,1),
	MAKH INT,
	MAKM INT, --Trường hợp chỉ áp dụng 1 mã KM cho 1 đơn hàng nhất định
	NGAYDATHANG DATETIME,
	NGAYGIAOHANG DATETIME,
	TRANGTHAI NVARCHAR(50),
	GHICHU NVARCHAR(100),
	FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
	FOREIGN KEY (MAKM) REFERENCES KHUYENMAI(MAKM)
)

CREATE TABLE CHITIETDONHANG
(
	MADH INT,
	MASP INT,
	SOLUONG INT,
	DONGIA FLOAT,
	PRIMARY KEY(MADH, MASP),
	FOREIGN KEY (MADH) REFERENCES DONHANG(MADH),
	FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
)

CREATE TABLE TOPPING
(
	MATOPPING INT PRIMARY KEY IDENTITY(1,1),
	TEN NVARCHAR(100),
	GIA FLOAT,
	HINHANH CHAR(100),
);

CREATE TABLE DONHANGTOPPING
(
	MATOPPING INT,
	MADH INT,
	SOLUONG INT,
	PRIMARY KEY (MATOPPING, MADH),
	FOREIGN KEY (MATOPPING) REFERENCES TOPPING(MATOPPING),
	FOREIGN KEY (MADH) REFERENCES DONHANG(MADH)
)

CREATE TABLE PHANHOI
(
	MAPHANHOI INT PRIMARY KEY IDENTITY(1,1),
	HOVATEN NVARCHAR(500),
	EMAIL NVARCHAR(500),
	NOIDUNG NVARCHAR(500)
)
DELETE FROM PHANHOI
DBCC CHECKIDENT (PHANHOI, RESEED, 0);



INSERT INTO LOAISANPHAM(TENLOAI)
VALUES
	(N'Trà trái cây'),
	(N'Trà sữa'),
	(N'Bánh ngọt'),
	(N'Cà phê'),
	(N'Đá xay'),
	(N'Sản phẩm đóng gói'),
	(N'Trà');


DBCC CHECKIDENT (SANPHAM, RESEED, 0);


INSERT INTO SANPHAM (TENSP, MOTA, GIA, HINHANH, MALOAI) VALUES
(N'Alisan Trái Cây', 
N'Alisan trái cây có hương vị tươi mát kết hợp với hạt chanh dây tạo nên hương vị độc đáo, 
hòa quyện hoàn hảo giữa vị chua nhẹ và ngọt thanh. Một lựa chọn tuyệt vời cho những ngày nắng nóng, 
giúp bạn thư giãn và tràn đầy năng lượng.',
30000,'AlisanTraiCay.jpg', 1),

(N'Alisan Vải', N'Alisan vải là một thức uống giải khát mát lạnh, 
kết hợp giữa trà Alisan thơm dịu và hương vị ngọt thanh của quả vải. 
Được phục vụ với đá viên, thức uống này mang đến cảm giác sảng khoái, ngọt ngào và tươi mát, 
rất thích hợp cho những ngày nắng nóng.', 
40000,'Alisanvai.jpg', 1),

(N'Đào Hồng Mận Hột É', N'Đào hồng mận hột é là thức uống có màu sắc bắt mắt, 
kết hợp vị ngọt thanh của đào, chút chua nhẹ của hồng mận và hương thơm đặc trưng. 
Hạt é giòn, dai tạo cảm giác thú vị khi uống. 
Đây là lựa chọn lý tưởng để giải nhiệt, đem lại cảm giác tươi mới và sảng khoái cho những ngày hè.'
, 32000,'Daohongman.jpg', 1),

(N'Đen Đào', N'Đen đào là một loại trà đen được pha cùng với hương vị đào, 
tạo nên một thức uống giải khát thơm mát và ngọt nhẹ. 
Thức uống này thường được pha chế với trà đen để có vị đắng nhẹ kết hợp với vị ngọt và hương thơm của đào, 
mang đến cảm giác dễ chịu và sảng khoái.
Để thêm phần hấp dẫn, đen đào thường được phục vụ với đá và đôi khi có thêm miếng đào tươi hoặc mứt đào để tăng cường hương vị trái cây tự nhiên.', 
28000,'dendao.jpg', 1),

(N'Hồng Trà Tắc Mật Ong', N'Hồng trà tắc mật ong là một loại thức uống kết hợp giữa hồng trà, nước tắc (quất), và mật ong, 
tạo nên hương vị chua ngọt, thơm mát. 
Hồng trà có vị đắng nhẹ và hương thơm tự nhiên, khi kết hợp với vị chua thanh của tắc và ngọt dịu của mật ong, tạo nên một thức uống thanh mát, phù hợp cho những ngày nóng bức. 
Hồng trà tắc mật ong thường được phục vụ với đá và trang trí bằng vài lát tắc cùng lá bạc hà, tạo cảm giác sảng khoái và hấp dẫn.', 
20000,'Hongtratac.jpg', 1),

(N'Trà Sữa Khoai Môn', N'Trà sữa khoai môn có vị béo của sữa, mùi thơm của khoai môn, vị chát nhẹ của trà. 
Thức uống này không quá ngọt, vị ngọt thanh, có chút béo bùi là điểm cộng lớn nhất của trà sữa khoai môn. ', 
25000,'Trasuakhoaimon.jpg', 2),

(N'Trà Sữa Trân Châu Đường Đen', N'Trà sữa trân châu đường đen có vẻ ngoài bắt mắt của cốc trà sữa với phần sữa trắng hòa quyện khéo léo cùng phần đường đen, trân châu đen bên dưới. 
Phần đường mía đen tự nhiên có độ ngọt vừa phải, giữ được vị thơm, bao phủ quanh các hạt trân châu, giúp tăng độ kết dính và độ thơm ngon cho thức uống này.', 
35000,'Tranchauduongden.jpg', 2),

(N'Trà Sữa Trân Châu ', N'Trà sữa trân châu với vị trà đậm đà, vị sữa béo ngọt kèm theo những hạt trân châu trắng tròn, nhỏ, có mùi thơm ngọt, giòn sần sật.', 
 25000,'Trasuatranchau.jpg',2),

(N'Trà Sữa Xoài Kem Cheese', N'Trà sữa xoài với vị ngọt đặc trưng của xoài, chút vị béo, mặn mặn của lớp kem cheese.
Đặc trưng của trà sữa xoài kem cheese là 1 vẻ bề ngoài với màu vàng đậm bắt mắt, kết hợp cùng lớp kem cheese trắng hấp dẫn phía trên.',
 33000,'Trasuaxoai.jpg', 2),

(N'Trà Sữa Đậu Đỏ Pudding Trứng', N'Trà sữa đậu đỏ pudding trứng có vị chát nhẹ của trà, vị ngọt béo từ sữa và ngọt thanh của đậu đỏ. 
Thêm vào đó là pudding trứng mềm mịn, thơm ngọt cùng chút béo ngậy của vani. 
Đặc biệt, những hạt đậu đỏ sẽ được chế biến mềm nhuyễn, khiến cốc trà sữa trở nên tuyệt vời hơn.', 
 28000,'Trasuadaudo.jpg', 2),

(N'Trà  Sữa Dâu', N'Trà sữa dâu với hương vị béo ngậy từ sữa, thơm mùi trà cùng với việc hơi chua nhẹ của dâu đánh thức toàn bộ vị giác của mình. 
Hơn thế nữa, những ly trà sữa dâu không chỉ kích thích vị giác của bạn mà còn cực kỳ nổi bật với một màu hồng dễ thương, xinh xắn.', 
25000,'Trasuadau.jpg', 2),

(N'Trà Sữa Bạc Hà', N'Trà sữa bạc hà có bạc hà thanh mát, cay dịu vừa đủ, thêm vị sữa ngậy ngậy, tất cả như hòa quyện, đọng lại đầu lưỡi, thật khó một từ ngữ nào có thể diễn tả được hương vị ấy.', 
 28000,'trasuabacha.jpg', 2),

(N'Trà Sữa Oolong', N'Trà sữa Oolong là sự hòa quyện của tinh túy giữa trà oolong vùng Bảo Lộc trứ danh và bột sữa thơm béo. 
Với tỷ lệ trà, sữa và đường phù hợp, mỗi ly trà sữa oolong có vị ngọt thanh dịu nhẹ, dễ dàng làm xiêu lòng mọi tín đồ trà sữa.', 
 25000,'TrasuaOolong.jpg', 2),

(N'Trà Sữa Matcha', N'Trà sữa Matcha là sự kết hợp hài hòa giữa trà Macha Nhật Bản cùng vị sữa thơm béo đồng thời mang đến cho người tiêu dùng một ly trà sữa matcha vừa tiện lợi, đảm bảo sức khỏe và phù hợp với khẩu vị các bạn trẻ Việt Nam.', 
 30000,'TrasuaMatcha.jpg', 2),

(N'Khoai Môn Đá Xay', N'Khoai môn đá xay là một món thức uống được làm từ khoai môn, sữa và đá, được xay nhuyễn để tạo thành hỗn hợp mịn màng, mát lạnh. 
Thức uống này có vị béo ngậy và hương thơm đặc trưng của khoai môn, thường được kết hợp thêm với kem tươi phía trên để tăng thêm độ béo và sự hấp dẫn. 
Khoai môn đá xay rất phù hợp để giải nhiệt và mang đến trải nghiệm ngọt ngào, mát lạnh. ', 
45000,'Khoaimondaxay.jpg',5),

(N'Matcha Đá Xay', N'Matcha đá xay có lớp đá xay màu xanh nhạt của bột trà xanh matcha, thường có vị thơm mát, hơi đắng nhẹ của matcha kết hợp với độ ngọt vừa phải. 
Phía trên là lớp kem mịn màu trắng, được rắc thêm một chút bột matcha, tạo nên hương vị béo ngậy hài hòa với vị trà xanh phía dưới. 
Đây là một lựa chọn phổ biến cho những ai yêu thích hương vị thanh mát, đặc trưng của matcha.',
 45000,'Matchadaxay.jpg', 5),

(N'Okinawa Latte', N'Okinawa Latte với lớp sữa tươi pha trộn cùng đường nâu Okinawa, tạo ra màu nâu đặc trưng loang lổ đẹp mắt trên thành ly. 
Phía trên là lớp trân châu đen bóng bẩy, dai và ngọt ngào, tạo thêm sự phong phú cho hương vị. 
Thức uống này có sự kết hợp hài hòa giữa vị ngọt đậm đà của đường nâu, vị béo ngậy của sữa và độ dai của trân châu, mang lại trải nghiệm mới lạ và hấp dẫn.', 
 30000,'OkiLatte.jpg', 1),

(N'Okinawa Milk Foam Smoothie', N'Okinawa Milk Foam Smoothie có lớp đá xay hòa quyện với sữa tươi và đường nâu Okinawa, tạo thành những vệt màu nâu đẹp mắt, mang đến hương vị ngọt ngào đặc trưng của đường nâu. 
Phía trên là lớp bọt sữa trắng mịn, béo ngậy, được trang trí với topping bánh quy vụn, tạo thêm điểm nhấn về hương vị và vẻ ngoài hấp dẫn. 
Phía dưới là lớp trân châu đen dai giòn, giúp cân bằng vị ngọt và tạo cảm giác thú vị khi thưởng thức.', 
35000,'Smoothie.jpg', 5),

(N'Trà Sen Vàng', N'Trà sen vàng với vị trà sen thơm thanh ngọt dịu, hòa quyện cùng lớp váng sữa thơm béo, hạt sen ngọt bùi và hạt gạo nổ giòn tan.', 
45000,'Trasenvang.jpg', 7),

(N'Chanh Aiyu Trân Châu Trắng', N'Chanh Aiyu trân châu trắng là thức uống mát lạnh, kết hợp giữa vị chua thanh của chanh tươi và thạch Aiyu mềm mại. 
Điểm nhấn của ly nước là lớp trân châu trắng giòn sần sật, tạo thêm trải nghiệm thú vị khi thưởng thức. 
Đây là lựa chọn hoàn hảo để giải nhiệt trong những ngày oi bức.', 
40000,'ChanhAiyu.jpg', 7),

(N'Mousse Xoài', 
N'Mousse Xoài có hương vị nhẹ nhàng và tươi mát với sự kết hợp của bánh bông lan mềm mịn, kem tươi béo ngậy và vị ngọt tự nhiên, 
mọng nước của xoài. Xoài cung cấp một vị ngọt thanh mát, kèm theo chút hương thơm đặc trưng, làm cho tổng thể chiếc bánh trở nên hấp dẫn. ', 
30000,'moussexoai.jpg', 3),

(N'Mousse 2 tầng', 
N'Mousse 2 tầng có thể mang đến sự ngọt ngào và nhẹ nhàng. 
Tầng mousse màu hồng có thể mang hương vị dâu, phúc bồn tử hoặc các loại quả mọng, đem lại vị ngọt thanh và hơi chua nhẹ, trong khi phần mousse màu trắng có thể là vị vani hoặc sữa, tạo nên sự béo ngậy nhẹ nhàng. 
Lớp đế bánh quy giòn phía dưới sẽ cân bằng với độ mềm của mousse, thêm chút giòn rụm để tạo nên sự thú vị cho mỗi miếng bánh.', 
 30000,'mouse.jpg', 3),

(N'Bông lan kem tươi', 
N'Bông lan kem tươi là một loại bánh cuộn mềm mịn với lớp bánh bông lan xốp nhẹ, được phủ kem tươi thơm ngon và nhân trái cây tươi như dâu tây, kiwi, cam, v.v. 
Bánh có hương vị ngọt nhẹ, độ mềm ẩm vừa phải, kết hợp với vị chua thanh của trái cây, tạo nên một món tráng miệng thanh mát và hấp dẫn.', 
35000,'bonglankemtuoi.jpg', 3),

(N'Bánh Brownies', 
N'Bánh brownies có lớp phủ caramel và sô-cô-la, kết hợp với đậu phộng giòn rụm bên trên. 
Phần đế bánh là lớp brownies đậm vị sô-cô-la, mềm ẩm và có chút đắng nhẹ đặc trưng. Lớp caramel ở giữa giúp tăng thêm độ ngọt và béo, đồng thời kết hợp với đậu phộng tạo cảm giác giòn tan. 
Phần phủ sô-cô-la bóng mịn trên cùng làm cho bánh trông hấp dẫn và đẹp mắt hơn, là một món tráng miệng lý tưởng cho những ai yêu thích vị sô-cô-la và caramel.', 
 35000,'brownies.jpg', 3),

(N'Bông lan chanh dây', 
N'Bông lan chanh dây với lớp mousse chanh dây mịn màng bên trên. Phần đế bánh là lớp bột mềm, hơi giòn, giúp tạo độ cân bằng cho kết cấu mịn màng của mousse. 
Lớp trên cùng có màu vàng tươi của chanh dây, trang trí thêm kem tươi, vụn hạt và lá bạc hà, tạo nên sự tinh tế và hài hòa cho món bánh. 
Hương vị chua ngọt của chanh dây kết hợp với độ béo nhẹ của kem và hương thơm của hạt giòn tan, mang lại cảm giác thanh mát và sảng khoái khi thưởng thức.', 
 33000,'banhchanhday.jpg', 3),

(N'Cheese cake', 
N'Bánh Cheese cake với đế bánh giòn, lớp kem phô mai mịn màng và phủ trên cùng là sốt anh đào đỏ thẫm cùng những quả anh đào mọng nước, tạo nên hương vị béo ngậy, ngọt thanh và chua nhẹ hấp dẫn.', 
32000,'cheesecake.jpg', 3),

(N'Cup cake', 
N'Cup cake với phần bánh mềm mịn, được phủ lớp kem bơ màu vàng nhạt xoắn cao phía trên, mang hương vị cam tươi mát. 
Mỗi chiếc cupcake còn được trang trí thêm một lát cam, tạo điểm nhấn hấp dẫn và tăng thêm hương vị trái cây tươi mới.', 
37000,'cupcake.jpg', 3),

(N'Tiramisu', 
N'Bánh Tiramisu với lớp dưới cùng là kem mịn được làm từ phô mai và kem tươi, phủ lên trên là bột cacao, một lát bánh quy, dâu tây tươi và trang trí với các bông hoa kem nhỏ. 
Sự kết hợp giữa lớp kem mịn, vị đắng nhẹ của cacao và dâu tươi tạo nên hương vị đặc biệt và hấp dẫn cho món tráng miệng này.', 
40000,'tiramisu.jpg', 3),

(N'Redvelvet', 
N'Bánh Redvelvet có hai lớp bông lan màu đỏ nhung xen kẽ với lớp kem trắng mịn ở giữa và trên cùng, tạo nên sự kết hợp giữa vị ngọt dịu và béo ngậy. 
Phần kem trang trí phía trên từng miếng bánh làm tăng thêm vẻ đẹp tinh tế và hấp dẫn.', 
 44000,'redvelvet.jpg', 3),

(N'Tiramisu trà xanh', 
N'Bánh Tiramisu trà xanh với lớp kem phô mai mịn, phủ bột matcha tạo vị đắng nhẹ và màu xanh tươi mát. 
Bánh có các lớp bánh mềm xen kẽ kem, mang lại hương vị thanh mát, béo ngậy và đặc trưng của trà xanh.', 
 45000,'tiramisutraxanh.jpg', 3),

(N'Phin sữa đá', 
N'Từng hạt cà phê hảo hạng được chọn bằng tay, phối trộn độc đáo giữa hạt Robusta từ cao nguyên Việt Nam, thêm Arabica thơm lừng. 
Cà phê được pha từ Phin truyền thống, hoà cùng sữa đặc sánh và thêm vào chút đá tạo nên ly Phin Sữa Đá – Đậm Đà Chất Phin.', 
25000,'phinsuada.jpg', 4),

(N'Bạc xỉu đá', 
N'Nếu Phin Sữa Đá dành cho các bạn đam mê vị đậm đà, thì Bạc Xỉu Đá là một sự lựa chọn nhẹ “đô" cà phê nhưng vẫn thơm ngon, chất lừ không kém!', 
 29000,'bacxiuda.jpg', 4),

(N'Phin đen đá', 
N'Cà phê đậm đà pha hoàn toàn từ Phin, cho thêm 1 thìa đường, một ít đá viên mát lạnh, tạo nên Phin Đen Đá mang vị cà phê đậm đà chất Phin.', 
20000,'phindenda.jpg', 4),

(N'Americano', 
N'Americano là sự kết hợp giữa cà phê espresso thêm vào nước đun sôi. Bạn có thể tùy thích lựa chọn uống nóng hoặc dùng chung với đá.', 
 35000,'americano.jpg', 4),

(N'Latte', 
N'Với một chút nhẹ nhàng hơn so với Cappuccino, Latte của chúng tôi bắt đầu với cà phê espresso, sau đó thêm sữa tươi và bọt sữa một cách đầy nghệ thuật. ', 
 39000,'cafelatte.jpg', 4),

(N'Caramel Macchiato', 
N'Ly cà phê Caramel Macchiato bắt đầu từ dòng sữa tươi và lớp bọt sữa béo ngậy, sau đó hòa quyện cùng cà phê espresso đậm đà và sốt caramel ngọt ngào.  ', 
 44000,'caramelmacchiato.jpg', 4),

(N'Espresso', 
N'Đích thực là ly cà phê espresso ngon đậm đà! Được chiết xuất một cách hoàn hảo từ loại cà phê rang được phối trộn độc đáo từ những hạt cà phê Robusta và Arabica chất lượng hảo hạng.  ', 
 40000,'espresso.jpg', 4),

(N'Mocha Macchiato', 
N'Một thức uống yêu thích được kết hợp bởi giữa sốt sô cô la ngọt ngào, sữa tươi và đặc biệt là cà phê espresso đậm đà.  ', 
 42000,'mochamacchiato.jpg', 4),

(N'Cappuccino', 
N'Một chút đậm đà hơn so với Latte, Cappuccino của chúng tôi bắt đầu với cà phê espresso, sau đó thêm một lượng tương đương giữa sữa tươi và bọt sữa cho thật hấp dẫn.  ', 
 45000,'cappuccino.jpg', 4),

(N'Phin Sữa Nóng', 
N'Phin Sữa Nóng kết hợp giữa hạt Robusta từ cao nguyên Việt Nam, thêm Arabica thơm lừng. 
Và kết hợp với nước sôi từng giọt cà phê được chiết xuất từ Phin truyền thống, hoà cùng sữa đặc sánh tạo nên ly Phin Sữa Nóng – Đậm đà chất Phin.  ', 
20000,'phinsuanong.jpg', 4),

(N'Phin Đen Nóng', 
N'Dành cho những tín đồ cà phê đích thực! Hương vị cà phê truyền thống được phối trộn độc. 
Cà phê đậm đà pha từ Phin, cho thêm 1 thìa đường, mang đến vị cà phê đậm đà chất Phin.   ', 
20000,'phindennong.jpg', 4),

(N'Cà Phê Rang Nguyên Hạt Royal Special 200g', 
N'Sau khi pha chế, sản phẩm có nước pha có màu nâu cánh gián đậm đẹp mắt với mùi thơm nhẹ, vị đắng đặc trưng của cà phê Việt Nam.
Cà phê Royal được sản xuất từ những hạt cà phê được tuyển chọn kỹ càng và sản xuất theo dây chuyền công nghệ hiện đại và bí quyết riêng không thể sao chép cho hương thơm nhẹ nhàng quyến rũ.  ', 
 75000,'cfnguyenhat200gr.jpg', 6),

(N'Cà Phê Rang Nguyên Hạt Royal Special 500g', 
N'Sau khi pha chế, sản phẩm có nước pha có màu nâu cánh gián đậm đẹp mắt với mùi thơm nhẹ, vị đắng đặc trưng của cà phê Việt Nam. 
Cà phê Royal được sản xuất từ những hạt cà phê được tuyển chọn kỹ càng và sản xuất theo dây chuyền công nghệ hiện đại và bí quyết riêng không thể sao chép cho hương thơm nhẹ nhàng quyến rũ. ', 
 204000,'cfnguyenhat500gr.jpg', 6),

(N'Cà Phê Rang Nguyên Hạt Robusta 200g', 
N'Hạt Cafe Robusta nhỏ hơn Arabica, vị đắng gắt, nhiều cafeine, loại này uống phê hơn. 
Hạt cà phê Robusta hình bàn cầu tròn và thường là 2 hạt trong 1 trái. Cà phê Robusta có mùi thơm dịu, vị đắng gắt, nước có màu nâu sánh, không chua, hàm lượng cafein vừa đủ đã tạo nên một loại cà phê đặc sắc phù hợp với khẩu vị của người dân Việt Nam. ', 
 60000,'robusta200g.jpg', 6),

(N'Cà Phê Rang Nguyên Hạt Robusta 500g', 
N'Hạt Cafe Robusta nhỏ hơn Arabica, vị đắng gắt, nhiều cafeine, loại này uống phê hơn. Hạt cà phê Robusta hình bàn cầu tròn và thường là 2 hạt trong 1 trái. 
Cà phê Robusta có mùi thơm dịu, vị đắng gắt, nước có màu nâu sánh, không chua, hàm lượng cafein vừa đủ đã tạo nên một loại cà phê đặc sắc phù hợp với khẩu vị của người dân Việt Nam. ', 
 156000,'robusta500.jpg', 6),

(N'Cà Phê Rang Nguyên Hạt Culi 200g', 
N'Hạt cà phê Culi là những hạt cà phê no tròn. Đặc biệt là trong một trái chỉ có duy nhất một hạt. 
Vị đắng gắt, hương thơm say đắm, hàm lượng cafein cao, nước mà đen sánh đó là những gì cà phê Culi mang đến. ', 
 55000,'culi200g.jpg', 6),

(N'Cà Phê Rang Nguyên Hạt Culi 500g', 
N'Hạt cà phê Culi là những hạt cà phê no tròn. Đặc biệt là trong một trái chỉ có duy nhất một hạt. 
Vị đắng gắt, hương thơm say đắm, hàm lượng cafein cao, nước mà đen sánh đó là những gì cà phê Culi mang đến. ', 
 130000,'culi500.jpg', 6),

(N'Cà Phê Rang Pha Trộn Robusta Culi 200g', 
N'Cà phê Robusta kết hợp cùng Culi cho vị ngon đậm đà thượng hạng mà vẫn thanh thoát đầy lôi cuốn. ', 
 58000,'robustaculi200g.jpg', 6),

(N'Cà Phê Rang Pha Trộn Robusta Culi 500g', 
N'Cà phê Robusta kết hợp cùng Culi cho vị ngon đậm đà thượng hạng mà vẫn thanh thoát đầy lôi cuốn. ', 
 135000,'robustaculi500g.jpg', 6),

(N'Cà Phê Rang Nguyên Hạt Moka 200g', 
N'Cà phê Moka thuộc dòng sản phẩm của Arabica, hạt có hình dáng thon dài và đường rãnh lượn sóng ở giữa hạt. 
Cà phê Moka có hương thơm nhẹ nhàng quyến rũ rất đặc trưng, vị từ chua chuyển sang hậu đắng rất đặc biệt. 
Khi pha cà phê có màu nâu nhạt sánh. Cà phê Moka sẽ là lựa chọn tuyệt vời cho những ai yêu thích cà phê sữa. ', 
 90000,'moka200g.jpg', 6),

(N'Cà Phê Rang Nguyên Hạt Moka 500g', 
N'Cà phê Moka thuộc dòng sản phẩm của Arabica, hạt có hình dáng thon dài và đường rãnh lượn sóng ở giữa hạt. 
Cà phê Moka có hương thơm nhẹ nhàng quyến rũ rất đặc trưng, vị từ chua chuyển sang hậu đắng rất đặc biệt. 
Khi pha cà phê có màu nâu nhạt sánh. Cà phê Moka sẽ là lựa chọn tuyệt vời cho những ai yêu thích cà phê sữa. ', 
 258000,'moka500g.jpg', 6),

(N'Cà Phê Rang Pha Trộn Arabica Culi 200g', 
N'Hương cà phê Arabica rất thơm, có vị chua, sau khi uống đọng lại cảm giác ngọt ở cổ họng. 
Arabica Cầu Đất có vị chua thanh xen lẫn với vị đắng nhẹ, nước pha màu nước nâu nhạt, trong trẻo của hổ phách. Mùi hương của Arabica rất thanh tao, quý phái, Arabica có mùi của si-rô, mùi của hoa trái, hòa quyện với mùi của mật ong, …  ', 
 65000,'arabicaculi200g.jpg', 6),

(N'Cà Phê Rang Pha Trộn Arabica Culi 500g', 
N'Hương cà phê Arabica rất thơm, có vị chua, sau khi uống đọng lại cảm giác ngọt ở cổ họng. 
Arabica Cầu Đất có vị chua thanh xen lẫn với vị đắng nhẹ, nước pha màu nước nâu nhạt, trong trẻo của hổ phách. Mùi hương của Arabica rất thanh tao, quý phái, Arabica có mùi của si-rô, mùi của hoa trái, hòa quyện với mùi của mật ong, …  ', 
 186000,'arabicaculi500g.jpg', 6),

(N'Cà Phê Rang Nguyên Hạt King 200g', 
N'Cà phê King là sự kết hợp hài hòa giữa 3 loại hạt Arabica, Robusta và Culi. Hương thơm nồng và vị cà phê mạnh mẽ, màu đen sánh đậm.  ', 
 80000,'king200g.jpg', 6),

(N'Cà Phê Rang Nguyên Hạt King 500g', 
N'Cà phê King là sự kết hợp hài hòa giữa 3 loại hạt Arabica, Robusta và Culi. Hương thơm nồng và vị cà phê mạnh mẽ, màu đen sánh đậm.  ', 
 220000,'king500g.jpg', 6);



INSERT INTO KICHTHUOC ( TENKICHTHUOC) VALUES
(N'Nhỏ'),
(N'Vừa'),
(N'Lớn');

INSERT INTO SANPHAMKICHTHUOC (MASP, MAKICHTHUOC, GIASIZE)
VALUES 
    (1, 1, 5000), (1, 2, 7000), (1, 3, 10000),
    (2, 1, 5000), (2, 2, 7000), (2, 3, 10000),
    (3, 1, 5000), (3, 2, 7000), (3, 3, 10000),
    (4, 1, 5000), (4, 2, 7000), (4, 3, 10000),
    (5, 1, 5000), (5, 2, 7000), (5, 3, 10000),
    (6, 1, 5000), (6, 2, 7000), (6, 3, 10000),
    (7, 1, 5000), (7, 2, 7000), (7, 3, 10000),
    (8, 1, 5000), (8, 2, 7000), (8, 3, 10000),
    (9, 1, 5000), (9, 2, 7000), (9, 3, 10000),
    (10, 1, 5000), (10, 2, 7000), (10, 3, 10000),
    (11, 1, 5000), (11, 2, 7000), (11, 3, 10000),
    (12, 1, 5000), (12, 2, 7000), (12, 3, 10000),
    (13, 1, 5000), (13, 2, 7000), (13, 3, 10000),
    (14, 1, 5000), (14, 2, 7000), (14, 3, 10000),
    (15, 1, 5000), (15, 2, 7000), (15, 3, 10000),
    (16, 1, 5000), (16, 2, 7000), (16, 3, 10000),
    (17, 1, 5000), (17, 2, 7000), (17, 3, 10000),
    (18, 1, 5000), (18, 2, 7000), (18, 3, 10000),
    (19, 1, 5000), (19, 2, 7000), (19, 3, 10000),
    (20, 1, 5000), (20, 2, 7000), (20, 3, 10000);

INSERT INTO TOPPING (TEN,GIA,HINHANH)
VALUES 
(N'Combo Hai Loại Hạt',15000,'Combo2loai.jpg'),
(N'Trân Châu Trắng',7000,'TranChauTrang.jpg'),
(N'Trân Châu Đen',7000,'TranChauDen.jpg'),
(N'Thạch Trái Cây',11000,'Thachtraicay.jpg'),
(N'Thạch Dừa',8000,'ThachDua.jpg'),
(N'Nha Đam',10000,'NhaDam.jpg'),
(N'Kem Sữa',17000,'KemSua.jpg'),
(N'Đậu Đỏ ',11000,'Daudo.jpg'),
(N'Combo Ba Loại Hạt',28000,'Combo3loai.jpg'),
(N'Pudding',10000,'PuddingTrung.jpg'),
(N'Sương Sáo',11000,'Suongsao.jpg');