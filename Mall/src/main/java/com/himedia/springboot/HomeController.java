package com.himedia.springboot;

import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	@Autowired
	private MallDAO mdao;

	@GetMapping("/")
	public String home(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String name = (String) session.getAttribute("name");
		if(name == null || name.equals("")) {
			model.addAttribute("name","");
		}else {
			model.addAttribute("name",name);
		}
		return "home";
	}
	@GetMapping("/signup")
	public String signup(){
		return "signon";
	}
	@PostMapping("/register")
	@ResponseBody
	public String register(HttpServletRequest req) {
		String url="";
		try {
			String userid = req.getParameter("userid");
			String pwd = req.getParameter("pwd");
			String name = req.getParameter("name");
			int mobile = Integer.parseInt(req.getParameter("mobile"));
			String address = req.getParameter("address");
			String email = req.getParameter("email");
			System.out.println(userid+pwd+name+mobile+address+email);
			int cnt = mdao.register(userid,pwd,name,mobile,address,email);
			System.out.println("register count["+cnt+"]");
			if(cnt>0) {
				url="/login";
			}else {
				url="/signup";
			}
		}catch (Exception e) {
			url="이미 존재하는 아이디입니다.";
		}
		return url;
	}
	@GetMapping("/login")
	public String login(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String name = (String) session.getAttribute("name");
		if(name == null || name.equals("")) {
			return "login";
		}else {
			return "redirect:/";
		}
	}
	@PostMapping("/signon")
	@ResponseBody
	public String signon(HttpServletRequest req) {
		String userid = req.getParameter("userid");
		String pwd = req.getParameter("pwd");
		String name = mdao.signon(userid,pwd);
		if(name != null) {
			HttpSession session = req.getSession();
			session.setAttribute("userid",userid);
			session.setAttribute("name",name);
			return name;
		}else {
			return "계정을 확인하세요.";
		}
//		ArrayList<signonDTO> alsignon = mdao.signon(userid,pwd);
//		JSONArray ja = new JSONArray();
//		JSONObject jo = new JSONObject();
//		jo.put("userid", alsignon.get(0).userid);
//		jo.put("name", alsignon.get(0).name);
//		jo.put("mobile", alsignon.get(0).mobile);
//		jo.put("address", alsignon.get(0).address);
//		jo.put("email", alsignon.get(0).email);
//		jo.put("level", alsignon.get(0).level);
//		jo.put("level_point", alsignon.get(0).level_point);
//		jo.put("cash", alsignon.get(0).cash);
//		ja.add(jo);
//		System.out.println("리스트 사이즈:"+alsignon.size());
//		if(alsignon.size()>=1) {
//			HttpSession session = req.getSession();
//			session.setAttribute("name",alsignon.get(0).name);
//			return ja.toJSONString();
//		}else {
//			return "계정을 확인하세요.";
//		}
	}
	@GetMapping("/logout")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.invalidate();
		return "redirect:/";
	}
	@PostMapping("/getList")
	@ResponseBody
	public String getList() {
		ArrayList<ListDTO> alList = mdao.getList();
		System.out.println(alList);
		JSONArray ja = new JSONArray();
		for(int i=0; i<alList.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("p_id",alList.get(i).p_id);
			jo.put("brand", alList.get(i).brand);
			jo.put("p_name", alList.get(i).p_name);
			jo.put("price", alList.get(i).price);
			jo.put("category_id", alList.get(i).category_id);
			jo.put("category", alList.get(i).category);
			jo.put("comment", alList.get(i).comment);
			jo.put("img", alList.get(i).img);
			jo.put("hit", alList.get(i).hit);
			jo.put("created", alList.get(i).created);
			jo.put("created", alList.get(i).created);
			ja.add(jo);
		}
		return ja.toJSONString();
	}
	@PostMapping("/getCList")
	@ResponseBody
	public String getCList(HttpServletRequest req) {
		String strC = req.getParameter("strC");
		ArrayList<ListDTO> alList = mdao.getCList(strC);
		System.out.println(alList);
		JSONArray ja = new JSONArray();
		for(int i=0; i<alList.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("p_id",alList.get(i).p_id);
			jo.put("brand", alList.get(i).brand);
			jo.put("p_name", alList.get(i).p_name);
			jo.put("price", alList.get(i).price);
			jo.put("category_id", alList.get(i).category_id);
			jo.put("category", alList.get(i).category);
			jo.put("comment", alList.get(i).comment);
			jo.put("img", alList.get(i).img);
			jo.put("hit", alList.get(i).hit);
			jo.put("created", alList.get(i).created);
			jo.put("created", alList.get(i).created);
			ja.add(jo);
		}
		return ja.toJSONString();
	}
	@GetMapping("/view")
	public String view(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String name = (String) session.getAttribute("name");
		if(name == null || name.equals("")) {
			model.addAttribute("name","");
		}else {
			model.addAttribute("name",name);
		}
		int p_id = Integer.parseInt(req.getParameter("p_id"));
		ListDTO ldto = mdao.view(p_id);
		mdao.hitup(p_id);
		model.addAttribute("vget",ldto);
		ArrayList<ColorDTO> cdto = mdao.color(p_id);
		JSONArray ja = new JSONArray();
		for(int i=0; i<cdto.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("p_id",cdto.get(i).p_id);
			jo.put("c_id",cdto.get(i).c_id);
			jo.put("color",cdto.get(i).color);
			ja.add(jo);
		}
		ja.toJSONString();
		System.out.println(ja);
		model.addAttribute("cget",ja);
		ArrayList<SizeDTO> sdto = mdao.getSize(p_id);
		JSONArray size = new JSONArray();
		for(int i=0; i<sdto.size(); i++) {
			JSONObject sizeO = new JSONObject();
			sizeO.put("p_id",sdto.get(i).p_id);
			sizeO.put("c_id",sdto.get(i).c_id);
			sizeO.put("size",sdto.get(i).size);
			sizeO.put("qty",sdto.get(i).qty);
			size.add(sizeO);
		}
		size.toJSONString();
		System.out.println(size);
		model.addAttribute("sget",size);
		return "view";
	}
}
