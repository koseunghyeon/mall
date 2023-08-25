package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MallDAO {
	int register(String userid, String pwd, String name, int mobile, String address, String email);
	String signon(String userid, String pwd);
	ArrayList<ListDTO> getList();
	ArrayList<ListDTO> getCList(String strC);
	ListDTO view(int p_id);
	void hitup(int p_id);
	ArrayList<ColorDTO> color(int p_id);
	ArrayList<SizeDTO> getSize(int p_id);
}
