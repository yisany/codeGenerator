import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* @author by ${authorName} on ${.now?string('yyyy-MM-dd')}
*/
@Service
public class ${classInfoDTO.className}ServiceImpl implements ${classInfoDTO.className}Service {

	@Resource
	private ${classInfoDTO.className}Mapper ${classInfoDTO.className?uncap_first}Mapper;


	@Override
	public ReturnT<String> insert(${classInfoDTO.className} ${classInfoDTO.className?uncap_first}) {

		// valid
		if (${classInfoDTO.className?uncap_first} == null) {
			return new ReturnT<String>(ReturnT.FAIL_CODE, "必要参数缺失");
        }

		${classInfoDTO.className?uncap_first}Mapper.insert(${classInfoDTO.className?uncap_first});
        return ReturnT.SUCCESS;
	}


	@Override
	public ReturnT<String> delete(int id) {
		int ret = ${classInfoDTO.className?uncap_first}Mapper.delete(id);
		return ret>0?ReturnT.SUCCESS:ReturnT.FAIL;
	}


	@Override
	public ReturnT<String> update(${classInfoDTO.className} ${classInfoDTO.className?uncap_first}) {
		int ret = ${classInfoDTO.className?uncap_first}Mapper.update(${classInfoDTO.className?uncap_first});
		return ret>0?ReturnT.SUCCESS:ReturnT.FAIL;
	}


	@Override
	public ${classInfoDTO.className} load(int id) {
		return ${classInfoDTO.className?uncap_first}Mapper.load(id);
	}


	@Override
	public Map<String,Object> pageList(int offset, int pagesize) {

		List<${classInfoDTO.className}> pageList = ${classInfoDTO.className?uncap_first}Mapper.pageList(offset, pagesize);
		int totalCount = ${classInfoDTO.className?uncap_first}Mapper.pageListCount(offset, pagesize);

		// result
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("pageList", pageList);
		result.put("totalCount", totalCount);

		return result;
	}

}
