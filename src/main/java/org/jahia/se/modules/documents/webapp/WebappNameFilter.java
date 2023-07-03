package org.jahia.se.modules.documents.webapp;

import org.apache.commons.lang.StringUtils;
import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.filter.AbstractFilter;
import org.jahia.services.render.filter.RenderChain;
import org.jahia.services.render.filter.RenderFilter;
import org.osgi.service.component.annotations.Component;

import java.util.Arrays;

@Component(service = RenderFilter.class)
public class WebappNameFilter extends AbstractFilter {
    public WebappNameFilter() {
        setApplyOnNodeTypes("doc4nt:document");
    }

    @Override
    public String prepare(RenderContext renderContext, Resource resource, RenderChain chain) throws Exception {

        Arrays.stream(resource.getNode().getPrimaryNodeType().getTemplatePackage().getResources("javascript/webapp"))
                .map(org.springframework.core.io.Resource::getFilename)
                .filter(filename -> StringUtils.startsWith(filename, "main.") && StringUtils.endsWith(filename, ".js"))
                .findFirst()
                .ifPresent(s -> renderContext.getRequest().setAttribute("webappJsFileName", s));

        Arrays.stream(resource.getNode().getPrimaryNodeType().getTemplatePackage().getResources("css/webapp"))
                .map(org.springframework.core.io.Resource::getFilename)
                .filter(filename -> StringUtils.startsWith(filename, "main.") && StringUtils.endsWith(filename, ".css"))
                .findFirst()
                .ifPresent(s -> renderContext.getRequest().setAttribute("webappCssFileName", s));
        return super.prepare(renderContext, resource, chain);
    }
}
