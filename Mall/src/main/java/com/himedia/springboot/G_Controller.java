package com.himedia.springboot;

import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class G_Controller {
	
	@Autowired
	private G_DAO g_dao;
	
	@GetMapping("g_board")
	public String g_board(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String name = (String) session.getAttribute("name");
		if(name == null || name.equals("")) {
			model.addAttribute("name","");
		}else {
			model.addAttribute("name",name);
		}
		ArrayList<g_boardDTO> g_alboard = g_dao.g_getBoard();
		System.out.println(g_alboard);
		JSONArray ja = new JSONArray();
		for(int i=0; i<g_alboard.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("num",g_alboard.get(i).num);
			jo.put("userid",g_alboard.get(i).userid);
			jo.put("seq",g_alboard.get(i).seq);
			jo.put("title",g_alboard.get(i).title);
			jo.put("content",g_alboard.get(i).content);
			jo.put("hit",g_alboard.get(i).hit);
			jo.put("created",g_alboard.get(i).created);
			jo.put("updated",g_alboard.get(i).updated);
			ja.add(jo);
		}
		ja.toJSONString();
		System.out.println(ja);
		model.addAttribute("getBoard",ja);
		return "g_board";
	}
	@GetMapping("g_write")
	public String g_write(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String userid = (String) session.getAttribute("userid");
		String name = (String) session.getAttribute("name");
		if(name == null || name.equals("")) {
			return "login";
		}else {
			model.addAttribute("userid",userid);
			model.addAttribute("name",name);
		}
		return "g_write";
	}
	@PostMapping("/boardInsert")
	public String boardInsert(HttpServletRequest req) {
		String title = req.getParameter("title");
		String userid = req.getParameter("author");
		String content = req.getParameter("content");
		g_dao.boardInsert(title,userid,content);
		return "redirect:/g_board";
	}
	@GetMapping("/g_view")
	public String g_view(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String userid = (String) session.getAttribute("userid");
		String name = (String) session.getAttribute("name");
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		System.out.println(boardNum);
		g_boardDTO gdto = g_dao.findBoard(boardNum);
		g_dao.g_hitup(boardNum);
		model.addAttribute("findingBoard",gdto);
		if(name == null || name.equals("")) {
			model.addAttribute("name","");
		}else {
			model.addAttribute("userid",userid);
			model.addAttribute("name",name);
		}
		ArrayList<g_commentDTO> commentdto = g_dao.findComment(boardNum);
		JSONArray ja = new JSONArray();
		for(int i=0; i<commentdto.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("userid",commentdto.get(i).userid);
			jo.put("b_num",commentdto.get(i).b_num);
			jo.put("c_num",commentdto.get(i).c_num);
			jo.put("comment",commentdto.get(i).comment);
			jo.put("updated",commentdto.get(i).updated);
			ja.add(jo);
		}
		ja.toJSONString();
		model.addAttribute("findingComment",ja);
		return "g_view";
	}
	@GetMapping("/g_delete")
	public String delete(HttpServletRequest req) {
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		g_dao.g_delete(boardNum);
		return "redirect:g_board";
	}
	@GetMapping("/g_update")
	public String update(HttpServletRequest req, Model model) {
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		HttpSession session = req.getSession();
		String userid = (String) session.getAttribute("userid");
		String name = (String) session.getAttribute("name");
		g_boardDTO gdto = g_dao.findBoard(boardNum);
		model.addAttribute("findingBoard",gdto);
		if(name == null || name.equals("")) {
			model.addAttribute("name","");
		}else {
			model.addAttribute("userid",userid);
			model.addAttribute("name",name);
		}
		return "g_update";
	}
	@PostMapping("/boardUpdate")
	public String boardUpdate(HttpServletRequest req) {
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		g_dao.boardUpdate(boardNum,title,content);
		return "redirect:/g_board";
	}
	@PostMapping("/insertComment")
	public String insertComment(HttpServletRequest req) {
		String userid = req.getParameter("userid");
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		String commentBox = req.getParameter("commentBox");
		g_dao.insertComment(userid,boardNum,commentBox);
		return "redirect:/g_view?boardNum="+boardNum;
	}
	@GetMapping("/g_commentDelete")
	public String g_commentDelete(HttpServletRequest req) {
		int c_num = Integer.parseInt(req.getParameter("c_num"));
		g_dao.g_commentDelete(c_num);
		return "redirect:/g_board";
	}
}
