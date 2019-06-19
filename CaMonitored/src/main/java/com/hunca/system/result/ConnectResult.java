package com.hunca.system.result;

import java.util.List;

import com.hunca.system.model.App;

import lombok.Data;
import lombok.experimental.Accessors;
@Accessors(chain=true)
@Data
public class ConnectResult {
	private List<App> allApp;//查询到的所有服务器
	private List<Integer> conApp;//已经关联的服务器
}
