package com.base.common.utils.file;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import com.base.common.utils.CodeUtil;
import com.base.common.utils.StringUtil;


/**
 * 文件工具类(屏蔽平台之间的文件操作差异)
 *
 * @author 
 * @version 2009-3-12
 * @see FileUtil
 * @since
 */
public final class FileUtil
{
    //根据当前的系统都识别 / 系统统一使用 、
    public final static String file_separator = "/";
    
    /**
     * Description:建立文件(可以同时建立文件需要的文件夹) <br>
     *
     * @param path
     * @return File 
     */
    public static File createFile(String path)
    {
        // 先格式化路径
        if (path == null || "".equals(path))
        {
            return null;
        }
        
        path = getPath(path);
        String mdr = path.substring(0, path.lastIndexOf(file_separator));
        
        File file = new File(mdr);
        
        if (!file.exists())
        {
            try
            {
                // 建立路径
                file.mkdirs();
            }
            catch (Exception e)
            {
                return null;
            }
            
        }
        
        return new File(path);
    }
    
    //判断文件路径是否存在
    public static boolean isFilePathexist(String path){
    	if(!StringUtil.isNull(path)){
    		return false;
    	}
    	File file = new File(path);
    	if (!file.exists()) {
    		return false;
    	}
    	return true;
    }
    
    //判断文件路径是否存在如果不存在那么就创建一个
    public static boolean isNewFilePath(String path){
    	if(StringUtil.isNull(path)){
    		return false;
    	}
    	File file = new File(path);
    	if (!file.exists()) {
    		file.mkdirs();
    	}
    	return true;
    }
    
    public static boolean delFile(String path)
    {
        //文件路径不能为空
        if (path == null || "".equals(path))
        {
            return false;
        }
        path = getPath(path);
        File file = new File(path);
        if (file.isFile() && file.exists())
        {
            try
            {
                // 删除文件
                file.delete();
            }
            catch (Exception e)
            {
                return false;
            }
        }
        return true;
    }
    
    public static boolean createFolders(String path)
    {
        // 先格式化路径
        if (path == null || "".equals(path))
        {
            return false;
        }
        
        path = getPath(path);
        
        File file = new File(path);
        
        if (!file.exists())
        {
            try
            {
                // 建立路径
                file.mkdirs();
            }
            catch (Exception e)
            {
                return false;
            }
        }
        return true;
    }
    
    /**
     * Description:从全部路径里面获得文件名称(GBK名称) <br>
     *
     * @param path
     * @return String 
     */
    public static String getFileName(String path)
    {
        path = path.replaceAll("\\\\", file_separator);
        
        return path.substring(path.lastIndexOf(file_separator) + 1,
                path.length());
    }
    
    /**
     * Description: 文件是否存在(如果是文件夹返回false)<br>
     *
     * @param filePath
     * @return boolean 
     */
    public static boolean isFileExist(String filePath)
    {
        File file = new File(filePath);
        
        return file.exists() && file.isFile();
    }
    
    /**
     * Description: 复制文件<br>
     * 
     * @param srcFile
     * @param dirFile
     * @return boolean
     * @throws 
     */
    public static boolean copyFile(String srcFile, String dirFile)
            throws IOException
    {
        FileOutputStream out = null;
        FileInputStream in = null;
        try
        {
            out = new FileOutputStream(getPath(dirFile));
            in = new FileInputStream(getPath(srcFile));
            copyFile(in, out);
        }
        catch (FileNotFoundException e)
        {
            throw e;
        }
        catch (IOException e)
        {
            throw e;
        }
        finally
        {
            try
            {
                if (out != null)
                {
                    out.close();
                }
                if (in != null)
                {
                    in.close();
                }
            }
            catch (IOException e)
            {
                
            }
        }
        
        return true;
    }
    
    /**
     * Description: 剪切文件<br>
     * 
     * @param srcFile
     * @param dirFile
     * @return boolean
     * @throws 
     */
    public static boolean cutFile(String srcFile, String dirFile)
            throws IOException
    {
        copyFile(srcFile, dirFile);
        
        File file = new File(srcFile);
        
        if (file != null)
        {
            try
            {
                file.delete();
            }
            catch (Exception e)
            {
                
            }
        }
        
        return true;
    }
    
    /**
     * Description:拷贝文件 <br>
     *
     * @param in in流
     * @param out out流
     * @return boolean
     * @throws IOException  
     */
    public static boolean copyFile(InputStream in, OutputStream out)
            throws IOException
    {
        if (in == null || out == null)
        {
            return false;
        }
        try
        {
            int bytesRead = 0;
            final int length = 8192;
            byte[] buffer = new byte[length];
            
            while ((bytesRead = in.read(buffer, 0, length)) != -1)
            {
                // write at server side
                out.write(buffer, 0, bytesRead);
            }
        }
        finally
        {
            if (in != null)
            {
                in.close();
            }
            if (out != null)
            {
                out.close();
            }
        }
        
        return true;
    }
    
    /**
     * Description: 获得本地认识的path(屏蔽平台之间的字符集设置)<br>
     *
     * @param path
     * @return String 
     */
    public static String getPath(String path)
    {
        path = path.replaceAll("\\\\", file_separator);
        
        try
        {
            path = new String(path.getBytes(CodeUtil.DEFAULT_CHARSET));
        }
        catch (UnsupportedEncodingException e)
        {
        }
        return path;
    }
    
    /**
     * Description:生成类似于xml的list <br>
     * 
     * @param path
     * @return
     * @throws Exception
     *             List
     */
    public static List<String> searchAll(String path) throws IOException
    {
        List<String> list = new ArrayList<String>();
        File file = new File(getPath(path));
        File[] f = file.listFiles();
        
        if (f == null)
        {
            return list;
        }
        
        if (f.length == 0)
        {
            return list;
        }
        
        list.add("<floder path =\"" + path + "\">");
        
        for (int i = 0; i < f.length; i++)
        {
            if (f[i].isFile())
            {
                list.add("<file>"
                        + new String(f[i].getName().getBytes(),
                                CodeUtil.DEFAULT_CHARSET) + "</file>");
            }
            else
            {
                list.addAll(searchAll(f[i].getPath()));
            }
        }
        
        list.add("</floder>");
        
        return list;
    }
    
    /**
     * Description:查询目录下的文件 <br>
     * 
     * @param path
     * @return List
     * @throws IOException
     */
    public static List<String> searchAllFile(String path) throws IOException
    {
        List<String> list = new ArrayList<String>();
        File file = new File(getPath(path));
        
        File[] f = file.listFiles();
        
        if (f == null)
        {
            return list;
        }
        
        if (f.length == 0)
        {
            return list;
        }
        
        for (int i = 0; i < f.length; i++)
        {
            if (f[i].isFile())
            {
                //这里获得GBK的路径
                list.add(new String(f[i].getAbsolutePath().getBytes(),
                		CodeUtil.DEFAULT_CHARSET));
            }
            else
            {
                list.addAll(searchAllFile(f[i].getPath()));
            }
        }
        
        return list;
    }
    
    public static int delFloder(String floderPath)
    {
        int result = 0;
        File file = new File(getPath(floderPath));
        
        File[] files = file.listFiles();
        
        if (files == null)
        {
            return result;
        }
        
        if (files.length == 0)
        {
            return result;
        }
        
        for (int i = 0; i < files.length; i++)
        {
            if (files[i].isFile())
            {
                result += files[i].delete() == true ? 1 : 0;
            }
            else
            {
                result += delFloder(files[i].getPath());
                try
                {
                    files[i].delete();
                }
                catch (Exception e)
                {
                    
                }
            }
        }
        
        return result;
    }
    
    /**
     * Description: 复制文件<br>
     * 
     * @param srcFile
     * @param dirFile
     * @return boolean
     * @throws FileNotFoundException
     */
    public static boolean copyFile(File srcFile, File dirFile)
            throws IOException
    {
        // 防止没有路径
        if (!srcFile.exists())
        {
            return false;
        }
        
        FileOutputStream out = null;
        FileInputStream in = null;
        try
        {
            out = new FileOutputStream(dirFile);
            in = new FileInputStream(srcFile);
            
            copyFile(in, out);
        }
        finally
        {
            try
            {
                if (out != null)
                {
                    out.close();
                }
                if (in != null)
                {
                    in.close();
                }
            }
            catch (IOException e)
            {
                
            }
        }
        
        return true;
    }
    
    /**
     * Description: 把srcFloder下面的文件夹以及子文件拷贝到dirFloder目录下<br>
     * 
     * @param srcFloder
     * @param dirFloder
     * @return int 拷贝的文件数
     * @throws IOException
     */
    public static int copyFloder(String srcFloder, String dirFloder)
            throws IOException
    {
        int copyCount = 0;
        File file = new File(getPath(srcFloder));
        File[] f = file.listFiles();
        
        // 格式化path
        dirFloder = getFormatPath(dirFloder);
        
        if (f == null)
        {
            return 0;
        }
        
        if (f.length == 0)
        {
            return 0;
        }
        
        for (int i = 0; i < f.length; i++)
        {
            if (f[i].isFile())
            {
                // 拷贝文件到目标目录 这里的f[i].getName()根据操作系统字符编码是根据操作系统决定的
                //但是拷贝到本机就无所谓的，这里不需要在转码
                boolean bb = copyFile(f[i], createFile(dirFloder
                        + f[i].getName()));
                copyCount += (bb == true ? 1 : 0);
            }
            else
            {
                createFolders(dirFloder + f[i].getName());
                copyCount += copyFloder(f[i].getPath(), dirFloder
                        + f[i].getName());
            }
        }
        
        return copyCount;
    }
    
    public static String getFilePostfix(String fileName)
    {
        if (fileName == null)
        {
            return null;
        }
        
        return fileName.substring(fileName.lastIndexOf('.') + 1);
    }
    
    /**
     * Description: (GBK编码的路径)格式化路径，使得路径后面是/或者\<br>
     *
     * @param path
     * @return String 
     */
    public static String getFormatPath(String path)
    {
        if (path == null)
        {
            return null;
        }
        
        // 替换文件路径，使用windows和aix，unix
        path = path.replaceAll("\\\\", file_separator);
        
        if (!path.substring(path.length() - 1).equals(file_separator))
        {
            path = path + file_separator;
        }
        
        try
        {
            path = new String(path.getBytes(CodeUtil.DEFAULT_CHARSET));
        }
        catch (UnsupportedEncodingException e)
        {
        }
        
        return path;
    }
    
    public static String readFile(File file) throws FileNotFoundException
    {
        BufferedReader br = null;
        StringBuffer sb = new StringBuffer();
        try
        {
            //            br = new BufferedReader(new FileReader(file));
            br = new BufferedReader(new InputStreamReader(new FileInputStream(
                    file), "UTF-8"));
            String temp = br.readLine();
            while (temp != null)
            {
                sb.append(temp);
                temp = br.readLine();
            }
        }
        catch (IOException e)
        {
        }
        finally
        {
            try
            {
                if (br != null)
                    br.close();
            }
            catch (IOException e)
            {
            }
        }
        return sb.toString().replaceAll("\r\n", "").replaceAll(" ", "");
    }
    
    /**
     * Description: <br>
     * 创建文件目录<br>
     * Implement: <br>
     * <br>
     * [参数列表，说明每个参数用途]
     * 
     * @return
     */
    public static boolean createDir(String fileDir)
    {
        // 如果不为空，创建文件目录
        if (null != fileDir)
        {
            File dir = new File(fileDir);
            if (!dir.exists() || !dir.isDirectory())
            {
                try
                {
                    // 创建新的文件目录
                    return dir.mkdirs();
                }
                catch (Exception e)
                {
                    e.printStackTrace();
                }
            }
        }
        return true;
    }
    
    
    
    /** 
     * 判断文件是否存在
     * @param fileName
     * @param dir
     * @return [参数说明]
     * 
     * @return boolean [返回类型说明]
     * @exception throws [异常类型] [异常说明]
     * @see [类、类#方法、类#成员]
     */
    public static boolean isFileExist(String fileName, String dir)
    {
        File files = new File(dir + fileName);
        return (files.exists()) ? true : false;
        
    }
}
