/*
 *  Copyright 2014-2015 snakerflow.com
 *  *
 *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  * you may not use this file except in compliance with the License.
 *  * You may obtain a copy of the License at
 *  *
 *  *     http://www.apache.org/licenses/LICENSE-2.0
 *  *
 *  * Unless required by applicable law or agreed to in writing, software
 *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * See the License for the specific language governing permissions and
 *  * limitations under the License.
 *
 */
package com.base.common.taglibs;

import javax.servlet.ServletContext;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.base.common.taglibs.builder.SelectTagBuilder;
import com.base.common.taglibs.builder.TagDTO;



/**
 * 自定义选择标签。根据选择的configName从缓存中获取配置列表，产生具体的select、radio或checkbox类型的控件
 * @author yuqs
 * @since 0.1
 */
public class SelectTag extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3678484078716531743L;
	//选择类型：select/radio/checkbox
	private String type;
	//字段名称
	private String name;
	//配置实体名称
	private String configName;
	//是否只读
	private String readOnly;
	//对象已选择的值
	private String value;
	//控件样式
	private String style;
	//控件css
	private String cssClass;
	//是否文本显示
	private String displayType;
	//配置数据来源，为空或0，默认从缓存获取，1为数据库中获取
	private String from;
	//Servlet的上下文
	private ServletContext servletContext;
	
	/**
	 * 继承RequestContextAwareTag的doStartTagInternal方法，实际上是doStartTag的模板方法
	 */
	@Override
	public int doStartTag() throws JspException {
		//获取ServletContext
		servletContext = pageContext.getServletContext();
		JspWriter writer = pageContext.getOut();
		try {
			TagDTO dto = new TagDTO(servletContext);
			dto.setProperty(SelectTagBuilder.NAME, name);
			dto.setProperty(SelectTagBuilder.TYPE, type);
			dto.setProperty(SelectTagBuilder.CONFIGNAME, configName);
			dto.setProperty(SelectTagBuilder.READONLY, readOnly);
			dto.setProperty(SelectTagBuilder.VALUE, value);
			dto.setProperty(SelectTagBuilder.STYLE, style);
			dto.setProperty(SelectTagBuilder.CSSCLASS, cssClass);
			dto.setProperty(SelectTagBuilder.DISPLAYTYPE, displayType);
			dto.setProperty(SelectTagBuilder.FROM, from);
			writer.write(SelectTagBuilder.builder.build(dto));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getConfigName() {
		return configName;
	}

	public void setConfigName(String configName) {
		this.configName = configName;
	}

	public String getReadOnly() {
		return readOnly;
	}

	public void setReadOnly(String readOnly) {
		this.readOnly = readOnly;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getCssClass() {
		return cssClass;
	}

	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}

	public String getDisplayType() {
		return displayType;
	}

	public void setDisplayType(String displayType) {
		this.displayType = displayType;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}
}
