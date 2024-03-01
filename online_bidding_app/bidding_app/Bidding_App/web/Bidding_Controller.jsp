<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Iterator"%>
<%@page import="Connection.dbconnection"%>
<%
    String KEY = request.getParameter("requestType").trim();
    System.out.println("Key : " + KEY);
    dbconnection dbobj = new dbconnection();
    if (KEY.equals("login")) {
        System.out.println("yess");
        String name = request.getParameter("U_name");
        String pass = request.getParameter("P_swd");
        String qry = "select regid,type from login where name='" + name + "'and email='" + pass + "' AND status='1'";
        Iterator itr = dbobj.getData(qry).iterator();
        if (itr.hasNext()) {
            Vector v = (Vector) itr.next();
            String res = v.get(0) + "#" + v.get(1);
            out.print(res);

            System.out.print(res);
        } else {
            out.print("failed");
            System.out.print("no");
        }
    }
    //user register
    if (KEY.equals("user_Register")) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String gen = request.getParameter("gendeer");
        String phon = request.getParameter("phone");
        String pass = request.getParameter("pass");
        String age = request.getParameter("card");

        String address = request.getParameter("address");
        String exp = request.getParameter("year");

        String ra = "0.0";
        String qry = "INSERT INTO `userregister`(`name`,`email`,`phone`,`pass`,`address`)VALUES('" + name + "','" + email + "','" + phon + "','" + pass + "','" + address + "')";
        String qry1login = "insert into login (regid,name,email,type,status)values((select max(uid)from userregister),'" + email + "','" + pass + "','user','1')";

        int rs = dbobj.putData(qry);

        int rss = dbobj.putData(qry1login);
        if (rs > 0 && rss > 0) {
        } else {
            out.print("failed");
            System.out.print("failed");
            out.print("sucess");
            System.out.print("sucess");
        }
    }

//add category
    if (KEY.equals("addcategory")) {
        String category = request.getParameter("category");
        String subcategory = request.getParameter("subcategory");
        LocalDate ll = LocalDate.now();
        String str = String.valueOf(ll);
        String qry = "INSERT INTO `category`(category,subcat)VALUES ('" + category + "','" + subcategory + "')";
        if (dbobj.putData(qry) > 0) {
            out.print("successful");
            System.out.println("Yes");
        } else {
            out.print("failed");
            System.out.println("No");

        }
    }

    //yes view subcategory
    if (KEY.equals("GETTherapyFilter")) {
        JSONArray array = new JSONArray();
        String dr = request.getParameter("Filter");
        String qry = "SELECT *FROM `category` WHERE `category`='" + dr + "'";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {

            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("id", v.get(0).toString().trim());
                obj.put("category", v.get(1).toString().trim());
                obj.put("subcategory", v.get(2).toString().trim());

                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }
    //

    if (KEY.equals("AddnewProduct")) {
        String uid = request.getParameter("uid");

        String name = request.getParameter("name");
        String details = request.getParameter("details");
        String family = request.getParameter("family");
        String origin = request.getParameter("origin");
        String max = request.getParameter("max");
        System.out.println(java.time.LocalDate.now());
        String consumable = request.getParameter("consumable");
        String image = request.getParameter("image");
        String updateqry = "INSERT INTO `addsell`(`name`,`description`,`category`,`subcategory`,`price`,`uid`,`image`,`max`,`todaydate`)values('" + name + "','" + details + "','" + origin + "','" + family + "','" + consumable + "','" + uid + "','" + image + "','" + max + "','" + java.time.LocalDate.now() + "')";
        System.out.print(updateqry);
        int rs = dbobj.putData(updateqry);

        if (rs > 0) {
            System.out.print("sucess");
            out.print("sucess");

        } else {
            out.print("failed");

            System.out.print("failed");
        }

    }

    //view list category
    if (KEY.equals("viewallcategory")) {
        JSONArray array = new JSONArray();
        String qry = "SELECT *FROM `category`";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {

            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();

                obj.put("category", v.get(1).toString().trim());
                obj.put("subcategory", v.get(2).toString().trim());
                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }
    //DisplayFull-ViewSubcategoryDetails
    if (KEY.equals("ViewSubcategoryDetails")) {
        JSONArray array = new JSONArray();
        String subcat = request.getParameter("subcat");
        String uid = request.getParameter("uid");

        String todaydate = java.time.LocalDate.now().toString();

        String qry = "SELECT addsell.* FROM `category`,`addsell` WHERE `addsell`.`subcategory`=`category`.`subcat` AND `addsell`.uid!=18 AND `addsell`.`subcategory`='" + subcat + "'";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {
            if (it.hasNext()) {

                Vector v = (Vector) it.next();
                SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
                String dbtoday = v.get(9).toString().trim();
                Date d1 = sdformat.parse(LocalDate.now().toString());
                Date d2 = sdformat.parse(v.get(9).toString());
                if (d1.compareTo(d2) == 0) {
                    System.out.println("Yes Same date Both of ");

                    JSONObject obj = new JSONObject();
                    obj.put("puid", v.get(0).toString().trim());
                    obj.put("pname", v.get(1).toString().trim());
                    obj.put("description", v.get(2).toString().trim());
                    obj.put("price", v.get(5).toString().trim());
                    obj.put("category", v.get(3).toString().trim());
                    obj.put("subcategory", v.get(4).toString().trim());
                    obj.put("image", v.get(7).toString().trim());
                    obj.put("min", v.get(8).toString().trim());
                    obj.put("today", v.get(9).toString().trim());
                    obj.put("status", "");
                    array.add(obj);
                }
            }
            out.println(array);

        } //            System.out.println(array);
        else {
            System.out.println("else id");
            out.print("failed");
        }

    }

//addbiddings
    if (KEY.equals("addbiddings")) {

        String amount = request.getParameter("amount");
        String dates = request.getParameter("dates");

        String pid = request.getParameter("pid");
        String uid = request.getParameter("uid");

        String updateqry = "INSERT INTO `bidding`(`pid`,`uid`,`amount`,`dates`,`status`)VALUES('" + pid + "','" + uid + "','" + dates + "','" + amount + "','n')";
        System.out.print(updateqry);
        int rs = dbobj.putData(updateqry);

        if (rs > 0) {
            System.out.print("sucess");
            out.print("sucess");

        } else {
            out.print("failed");

            System.out.print("failed");
        }

    }

    //viewmybidding
    if (KEY.equals("viewmybidding")) {
        JSONArray array = new JSONArray();
        String uid = request.getParameter("uid");

        String qry = "SELECT `addsell`.*,`bidding`.`dates`,bidding.status,bidding.bid,bidding.dates FROM `addsell`,`bidding`,`userregister` WHERE `bidding`.uid=`userregister`.`uid` AND `bidding`.`pid`=`addsell`.`sid` AND `bidding`.uid='" + uid + "'";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("puid", v.get(0).toString().trim());
                obj.put("pname", v.get(1).toString().trim());
                obj.put("description", v.get(2).toString().trim());
                obj.put("min", v.get(8).toString().trim());
                obj.put("category", v.get(3).toString().trim());
                obj.put("subcategory", v.get(4).toString().trim());
                obj.put("image", v.get(7).toString().trim());
                obj.put("max", v.get(8).toString().trim());//max on db
                obj.put("price", v.get(10).toString().trim());
                obj.put("today", v.get(9).toString().trim());

                obj.put("status", v.get(11).toString().trim());
                obj.put("id", v.get(12).toString().trim());

                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }
    //

    //viewmybidding
    if (KEY.equals("viewmysllimg")) {
        JSONArray array = new JSONArray();
        String uid = request.getParameter("uid");

        String qry = "SELECT DISTINCT `addsell`.*,`bidding`.`dates`,bidding.status FROM `addsell`,`bidding`,`userregister` WHERE `bidding`.uid=`userregister`.`uid` AND `bidding`.`pid`=`addsell`.`sid` AND `bidding`.uid!='" + uid + "' AND `addsell`.`uid`='" + uid + "'";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("puid", v.get(0).toString().trim());
                obj.put("pname", v.get(1).toString().trim());
                obj.put("description", v.get(2).toString().trim());
                obj.put("price", v.get(10).toString().trim());
                obj.put("category", v.get(3).toString().trim());
                obj.put("subcategory", v.get(4).toString().trim());
                obj.put("image", v.get(7).toString().trim());
                obj.put("today", v.get(9).toString().trim());

                obj.put("min", v.get(8).toString().trim());
                obj.put("status", v.get(10).toString().trim());

                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }
    //reviews
    //DisplayFull-
    if (KEY.equals("reviews")) {

        String description = request.getParameter("description");
        String star = request.getParameter("star");
        String uid = request.getParameter("uid");

        String updateqry = "INSERT INTO `reviews`(`uid`,`description`,`stars`)VALUES('" + uid + "','" + description + "','" + star + "')";
        System.out.print(updateqry);
        int rs = dbobj.putData(updateqry);

        if (rs > 0) {
            System.out.print("sucess");
            out.print("sucess");

        } else {
            out.print("failed");

            System.out.print("faield");
        }

    }
    //updated
    if (KEY.equals("updatedbids")) {

        String amount = request.getParameter("amount");
        String dates = request.getParameter("dates");
        String dd = dates + ",";
        String pid = request.getParameter("pid");
        String uid = request.getParameter("uid");

        String updateqry = "update `bidding` SET  `dates`='" + amount + "' WHERE `bid`='" + pid + "'";
        System.out.print(updateqry);
        int rs = dbobj.putData(updateqry);

        if (rs > 0) {
            System.out.print("sucess");
            out.print("sucess");

        } else {
            out.print("failed");

            System.out.print("faield");
        }

    }

    //viewmybidding
    if (KEY.equals("allreviewdata")) {
        JSONArray array = new JSONArray();
        String uid = request.getParameter("uid");

        String qry = "SELECT `userregister`.`name`,`userregister`.`email`,`reviews`.`description`,`reviews`.`stars` FROM `userregister`,`reviews` WHERE `reviews`.`uid`=`userregister`.`uid`";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("name", v.get(0).toString().trim());
                obj.put("pemail", v.get(1).toString().trim());
                obj.put("description", v.get(2).toString().trim());
                obj.put("dates", v.get(3).toString().trim());

                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }//

//viewmybidding
    if (KEY.equals("viewHistoryAdmin")) {
        JSONArray array = new JSONArray();

        String qry = "SELECT DISTINCT `addsell`.*,`bidding`.`dates`,bidding.status,`userregister`.`name`,`userregister`.`email`,`userregister`.`phone` FROM `userregister`,`addsell`,`bidding` WHERE `bidding`.`uid`=`userregister`.`uid` AND `addsell`.`sid`=`bidding`.`pid`";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("puid", v.get(0).toString().trim());
                obj.put("pname", v.get(1).toString().trim());
                obj.put("description", v.get(2).toString().trim());
                obj.put("price", v.get(9).toString().trim());
                obj.put("category", v.get(3).toString().trim());
                obj.put("subcategory", v.get(4).toString().trim());
                obj.put("image", v.get(7).toString().trim());
                obj.put("min", v.get(8).toString().trim());
                obj.put("status", v.get(10).toString().trim());

                obj.put("name", v.get(11).toString().trim());
                obj.put("pemail", v.get(12).toString().trim());
                obj.put("phone", v.get(13).toString().trim());

                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }
    //calculatefirstidding

    if (KEY.equals("calculatefirstidding")) {
        SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
        String qry = "SELECT`bidding`.`bid`,`bidding`.pid,`bidding`.`dates`,`addsell`.`todaydate`,`addsell`.`max`,`bidding`.`status`,`addsell`.`sid` FROM `addsell`,`bidding` WHERE `bidding`.`pid`=`addsell`.`sid`";
        Iterator it = dbobj.getData(qry).iterator();
        while (it.hasNext()) {
            Vector v = (Vector) it.next();
            Date d1 = sdformat.parse(LocalDate.now().toString());
            Date d2 = sdformat.parse(v.get(3).toString());
            if (d1.compareTo(d2) != 0) {
                System.out.println("Yes not dody : " + d2);
                String up = "SELECT `bid`,`pid`, MAX(`dates`) FROM `bidding`,`addsell` WHERE `addsell`.`sid`=`bidding`.`pid` AND `bidding`.`pid`='" + v.get(6) + "' GROUP BY pid";
                Vector upvec = null;
                Iterator upit = dbobj.getData(up).iterator();
                if (upit.hasNext()) {
                    upvec = (Vector) upit.next();

                    System.out.println(upvec.get(1) + " : " + upvec.get(2));

                    String uoqry = "UPDATE `bidding` SET `status`='y' WHERE dates='" + upvec.get(2) + "' and pid='" + upvec.get(1) + "'";
                    System.out.println(uoqry);
                    int upcon = dbobj.putData(uoqry);
                    if (upcon > 0) {
                        System.out.println("Yes Updated");
                    }
                    String uoqry2 = "UPDATE `bidding` SET `status`='u' WHERE dates!='" + upvec.get(2) + "' and pid='" + upvec.get(1) + "'";
                    System.out.println(uoqry);
                    int upcon2 = dbobj.putData(uoqry2);
                    if (upcon2 > 0) {
                        System.out.println("Yes unsucess");
                    }

                } else {

                }
            }

        }
    }
    //

//addbiddings
    if (KEY.equals("complaints")) {

        String amount = request.getParameter("nam");
        String dates = request.getParameter("des");

        String pid = request.getParameter("pur");
        String uid = request.getParameter("uid");

        String updateqry = "INSERT INTO `complaint`(`uid`,`unam`,`purpose`,`des`,`satatus`)VALUES('" + uid + "','" + amount + "','" + pid + "','" + dates + "','n')";
        System.out.print(updateqry);
        int rs = dbobj.putData(updateqry);

        if (rs > 0) {
            System.out.print("sucess");
            out.print("sucess");

        } else {
            out.print("failed");

            System.out.print("failed");
        }

    }
    //get data

//viewmybidding
    if (KEY.equals("viewcomplaints")) {
        JSONArray array = new JSONArray();
        String uid = request.getParameter("uid");

        String qry = "SELECT  `complaint`.*,`userregister`.* FROM `complaint`,`userregister` WHERE `userregister`.`uid`=`complaint`.`uid`";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("id", v.get(0).toString().trim());

                obj.put("max", v.get(2).toString().trim());
                obj.put("min", v.get(3).toString().trim());
                obj.put("dates", v.get(4).toString().trim());
                obj.put("status", v.get(5).toString().trim());
                obj.put("name", v.get(7).toString().trim());
                obj.put("pemail", v.get(8).toString().trim());
                obj.put("phone", v.get(9).toString().trim());
                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }//

//upadte
    //updated
    if (KEY.equals("upadesdcompliants")) {
        String uid = request.getParameter("uid");

        String updateqry = "update `complaint` SET  `satatus`='y' WHERE `cid`='" + uid + "'";
        System.out.print(updateqry);
        int rs = dbobj.putData(updateqry);

        if (rs > 0) {
            System.out.print("sucess");
            out.print("sucess");

        } else {
            out.print("failed");

            System.out.print("failed");
        }

    }
    //conf

    if (KEY.equals("getconfirmbidd")) {
        JSONArray array = new JSONArray();
        
        String qry = "SELECT DISTINCT `addsell`.*,`bidding`.`dates`,bidding.status,`userregister`.`name`,`userregister`.`email`,`userregister`.`phone`,bidding.bid FROM `userregister`,`addsell`,`bidding` WHERE `bidding`.`uid`=`userregister`.`uid` AND `addsell`.`sid`=`bidding`.`pid` and `bidding`.`status`='y'";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("puid", v.get(0).toString().trim());
                obj.put("pname", v.get(1).toString().trim());
                obj.put("description", v.get(2).toString().trim());
                obj.put("price", v.get(10).toString().trim());
                obj.put("category", v.get(3).toString().trim());
                obj.put("subcategory", v.get(4).toString().trim());
                obj.put("image", v.get(7).toString().trim());
                obj.put("min", v.get(8).toString().trim());
                obj.put("status", v.get(11).toString().trim());
                obj.put("today", v.get(9).toString().trim());
                obj.put("name", v.get(12).toString().trim());
                obj.put("pemail", v.get(13).toString().trim());
                obj.put("phone", v.get(14).toString().trim());
                obj.put("id", v.get(15).toString().trim());
                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }
    //user register
    if (KEY.equals("deliveryboy")) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phon = request.getParameter("phone");
        String pass = request.getParameter("pass");

        String add = request.getParameter("add");

        String ra = "0.0";
        String qry = "INSERT INTO `delivery`(`name`,`email`,`phone`,`adds`,`pass`)VALUES('" + name + "','" + email + "','" + phon + "','" + add + "','" + pass + "')";
        String qry1login = "insert into login (regid,name,email,type,status)values((select max(dlid)from delivery),'" + email + "','" + pass + "','del','1')";

        int rs = dbobj.putData(qry);

        int rss = dbobj.putData(qry1login);
        if (rs > 0 && rss > 0) {
        } else {
            out.print("failed");
            System.out.print("failed");
            out.print("sucess");
            System.out.print("sucess");
        }
    }
    //

    //yes view subcategory
    if (KEY.equals("getalldeliveryman")) {
        JSONArray array = new JSONArray();
        String dr = request.getParameter("Filter");
        String qry = "SELECT *FROM `delivery`";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {

            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("id", v.get(0).toString().trim());
                obj.put("category", v.get(1).toString().trim());
                obj.put("subcategory", v.get(2).toString().trim());

                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }
    //

    //updated
    if (KEY.equals("assigned")) {
        String dd = request.getParameter("delid");
        String uid = request.getParameter("bidid");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();

        String updateqry = "INSERT INTO `assigned`(`pidid`,`delid`,`dates`,`status`)values('" + uid + "','" + dd + "','" + now + "','n')";
        System.out.print(updateqry);
        int rs = dbobj.putData(updateqry);

        if (rs > 0) {
            System.out.print("sucess");
            out.print("sucess");

        } else {
            out.print("failed");

            System.out.print("failed");
        }

    }
    //conf

//viewmybidding
    if (KEY.equals("viewnewnotification")) {
        JSONArray array = new JSONArray();
        String uid = request.getParameter("uid");

        String qry = "SELECT `assigned`.`aid`,`userregister`.`name`,`userregister`.`email`,`userregister`.`phone` ,`bidding`.`dates`,`addsell`.`name`,`addsell`.`subcategory`,`assigned`.`status` FROM `addsell`,`userregister`,`assigned`,`bidding` WHERE `bidding`.`pid`=`addsell`.`sid` AND `bidding`.bid=`assigned`.`pidid` AND `assigned`.`delid`='" + uid + "' AND `bidding`.`uid`=`userregister`.`uid`";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("id", v.get(0).toString().trim());

                obj.put("max", v.get(4).toString().trim());
                obj.put("min", v.get(5).toString().trim());
                obj.put("dates", v.get(6).toString().trim());
                obj.put("status", v.get(7).toString().trim());
                obj.put("name", v.get(1).toString().trim());
                obj.put("pemail", v.get(2).toString().trim());
                obj.put("phone", v.get(3).toString().trim());
                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }//

//upadte
    //updated
    if (KEY.equals("deliveryupadted")) {
        String uid = request.getParameter("uid");

        String updateqry = "update `assigned` SET  `status`='y' WHERE `aid`='" + uid + "'";
        System.out.print(updateqry);
        int rs = dbobj.putData(updateqry);

        if (rs > 0) {
            System.out.print("sucess");
            out.print("sucess");

        } else {
            out.print("failed");

            System.out.print("failed");
        }

    }
    //conf

//viewmybidding
    if (KEY.equals("searchingdata")) {
        String se = request.getParameter("search");
        String h = se.substring(0);
        JSONArray array = new JSONArray();

        String qry = "SELECT DISTINCT `addsell`.*,`bidding`.`dates`,`bidding`.`status`,`userregister`.`name`,`userregister`.`email`,`userregister`.`phone` FROM `bidding`,`addsell`,`userregister` WHERE `addsell`.sid=`bidding`.`pid` AND `userregister`.`uid`=`bidding`.`uid` AND `addsell`.`subcategory`='" + se + "'";

        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {
            String s = "SELECT *FROM `addsell` WHERE `subcategory`='" + se + "'";
            Iterator hh = dbobj.getData(s).iterator();

            if (hh.hasNext()) {
                while (it.hasNext()) {
                    Vector v = (Vector) it.next();
                    JSONObject obj = new JSONObject();
                    obj.put("puid", v.get(0).toString().trim());
                    obj.put("pname", v.get(1).toString().trim());
                    obj.put("description", v.get(2).toString().trim());
                    obj.put("today", v.get(9).toString().trim());
                    obj.put("price", v.get(10).toString().trim());
                    obj.put("category", v.get(3).toString().trim());
                    obj.put("subcategory", v.get(4).toString().trim());
                    obj.put("image", v.get(7).toString().trim());
                    obj.put("min", v.get(8).toString().trim());
                    obj.put("status", v.get(11).toString().trim());
                    obj.put("name", v.get(12).toString().trim());
                    obj.put("pemail", v.get(13).toString().trim());
                    obj.put("phone", v.get(14).toString().trim());

                    array.add(obj);
                }
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }

//
    if (KEY.equals("gettotalsumofvalues")) {
        String name = request.getParameter("puid");

        String qry = "SELECT MAX(dates) FROM `bidding` WHERE pid='" + name + "'";

        Iterator itr = dbobj.getData(qry).iterator();
        if (itr.hasNext()) {
            Vector v = (Vector) itr.next();
            String res = v.get(0).toString();
            out.print(res);

            System.out.print(res);
        } else {
            out.print("failed");
            System.out.print("no");
        }
    }

    //updated
    
    if (KEY.equals("payemtassign")) {
        String card = request.getParameter("card");
        String cvv = request.getParameter("cvv");
        String exp = request.getParameter("exp");
        String amt = request.getParameter("amt");
        String uid = request.getParameter("uid");
        String bid = request.getParameter("bid");
        String asid = request.getParameter("asid");

        String updateqry = "INSERT INTO `payment`(`card`,`cvv`,`exp`,`amt`,`uid`,`bid`,`sid`)"
                + "VALUES('" + card + "','" + cvv + "','" + exp + "','" + amt + "','" + uid + "','" + bid + "','" + asid + "')";
        System.out.print(updateqry);
        int rs = dbobj.putData(updateqry);

        if (rs > 0) {
            System.out.print("sucess");
            out.print("sucess");

        } else {
            out.print("failed");

            System.out.print("failed");
        }

    }
    //getdata
     if (KEY.equals("finalbookconfirm")) {
        JSONArray array = new JSONArray();
        String uid=request.getParameter("uid");
        String qry = "SELECT DISTINCT `addsell`.*,`bidding`.`dates`,bidding.status,`userregister`.`name`,`userregister`.`email`,`userregister`.`phone`,bidding.bid FROM `bidding`,`payment`,`addsell`,`userregister` WHERE `bidding`.`bid`=`payment`.`bid` AND `addsell`.`sid`=`bidding`.`pid` AND `payment`.`uid`='"+uid+"'";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("puid", v.get(0).toString().trim());
                obj.put("pname", v.get(1).toString().trim());
                obj.put("description", v.get(2).toString().trim());
                obj.put("price", v.get(10).toString().trim());
                obj.put("category", v.get(3).toString().trim());
                obj.put("subcategory", v.get(4).toString().trim());
                obj.put("image", v.get(7).toString().trim());
                obj.put("min", v.get(8).toString().trim());
                obj.put("status", v.get(11).toString().trim());
                obj.put("today", v.get(9).toString().trim());
                obj.put("name", v.get(12).toString().trim());
                obj.put("pemail", v.get(13).toString().trim());
                obj.put("phone", v.get(14).toString().trim());
                obj.put("id", v.get(15).toString().trim());
                                obj.put("confirm", "ConfirmPaid");

                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }
     

     if (KEY.equals("assignDelivry_Confirmbid")) {
        JSONArray array = new JSONArray();
        String uid=request.getParameter("uid");
        String qry = "SELECT DISTINCT `addsell`.*,`bidding`.`dates`,bidding.status,`userregister`.`name`,`userregister`.`email`,`userregister`.`phone`,bidding.bid FROM `bidding`,`payment`,`addsell`,`userregister` WHERE `bidding`.`bid`=`payment`.`bid` AND `addsell`.`sid`=`bidding`.`pid`";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("puid", v.get(0).toString().trim());
                obj.put("pname", v.get(1).toString().trim());
                obj.put("description", v.get(2).toString().trim());
                obj.put("price", v.get(10).toString().trim());
                obj.put("category", v.get(3).toString().trim());
                obj.put("subcategory", v.get(4).toString().trim());
                obj.put("image", v.get(7).toString().trim());
                obj.put("min", v.get(8).toString().trim());
                obj.put("status", v.get(11).toString().trim());
                obj.put("today", v.get(9).toString().trim());
                obj.put("name", v.get(12).toString().trim());
                obj.put("pemail", v.get(13).toString().trim());
                obj.put("phone", v.get(14).toString().trim());
                obj.put("id", v.get(15).toString().trim());
                                obj.put("confirm", "ConfirmPaid");

                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }


//
    if (KEY.equals("checkbiddingranging")) {
        
        String name = request.getParameter("uid");
        String qry = "SELECT COUNT(uid) FROM `bidding` WHERE `uid`='"+name+"'";
        Iterator itr = dbobj.getData(qry).iterator();
        if (itr.hasNext()) {
            Vector v = (Vector) itr.next();
            String res = v.get(0).toString();
            
            if(Integer.parseInt(v.get(0).toString()) >5){
                out.print("yes");
            }else{
                 out.print("no");
            }            
            System.out.print(res);
        }
        else{
                 out.print("no");
            }           
    }
    
  
    if (KEY.equals("morepayment")) {
        String card = request.getParameter("card");
        String cvv = request.getParameter("cvv");
        String exp = request.getParameter("exp");
        String amt = request.getParameter("amt");
        String uid = request.getParameter("uid");
        String asid = request.getParameter("addsellid");

        String updateqry = "INSERT INTO `morepayment`(`card`,`cvv`,`exp`,`amt`,`uid`,`sid`)"
                + "VALUES('" + card + "','" + cvv + "','" + exp + "','" + amt + "','" + uid + "','" + asid + "')";
        System.out.print(updateqry);
        int rs = dbobj.putData(updateqry);

        if (rs > 0) {
            System.out.print("sucess");
            out.print("sucess");

        } else {
            out.print("failed");

            System.out.print("failed");
        }

    }
    //
        //getdata
     if (KEY.equals("abovefivedata")) {
        JSONArray array = new JSONArray();
        String uid=request.getParameter("uid");
        String qry = "SELECT *FROM `addsell`,`morepayment`,`userregister` WHERE `morepayment`.uid=`userregister`.`uid` AND `morepayment`.sid=`addsell`.`sid`";
        System.out.println("qry=" + qry);
        Iterator it = dbobj.getData(qry).iterator();
        if (it.hasNext()) {
            while (it.hasNext()) {
                
                Vector v = (Vector) it.next();
                JSONObject obj = new JSONObject();
                obj.put("puid", v.get(0).toString().trim());
                obj.put("pname", v.get(1).toString().trim());
                obj.put("description", v.get(18).toString().trim());
                obj.put("price", v.get(11).toString().trim());
                obj.put("category", v.get(3).toString().trim());
                obj.put("subcategory", v.get(4).toString().trim());
                obj.put("image", v.get(7).toString().trim());
                obj.put("min", v.get(8).toString().trim());
                obj.put("status", v.get(11).toString().trim());
                obj.put("today", v.get(20).toString().trim());
                obj.put("name", v.get(18).toString().trim());
                obj.put("pemail", v.get(19).toString().trim());
                obj.put("phone", v.get(21).toString().trim());
                obj.put("id", v.get(15).toString().trim());

                array.add(obj);
            }
            System.out.println(array);
            out.println(array);
        } else {
            System.out.println("else id");
            out.print("failed");
        }
    }
     
    
%>

