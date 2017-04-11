/*!
 * B-JUI v1.0 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan (xknaan@163.com).
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-navtab.js v1.0
 * @author K'naan (xknaan@163.com)
 * -- Modified from dwz.navTab.js (author:ZhangHuihua@msn.com)
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-navtab.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // NAVTAB GLOBAL ELEMENTS
    // ======================
    
    var currentIndex, $currentTab, $currentPanel, $box, $tabs, $panels, $prevBtn, $nextBtn, $moreBtn, $moreBox, $main, $mainLi
    
    $(function() {
        var INIT_NAVTAB = function() {
            currentIndex = 1
            $box         = $('#bjui-navtab')
            $tabs        = $box.find('.navtab-tab')
            $panels      = $box.find('.navtab-panel')
            $prevBtn     = $box.find('.tabsLeft')
            $nextBtn     = $box.find('.tabsRight')
            $moreBtn     = $box.find('.tabsMore')
            $moreBox     = $box.find('.tabsMoreList')
            $main        = $tabs.find('li.main')
            $mainLi      = $moreBox.find('li:first')
            
            $prevBtn.click(function() { $(this).navtab('scrollPrev') })
            $nextBtn.click(function() { $(this).navtab('scrollNext') })
            $moreBtn.click(function() { $moreBox.show() })
            
            $(document).on('click.bjui.navtab.switchtab', function(e) {
                var $target = e.target.tagName == 'I' ? $(e.target).parent() : $(e.target)
                
                if ($moreBtn[0] != $target[0]) $moreBox.hide()
            })
            
            $main
                .navtab('contextmenu', $main)
                .click(function() { $(this).navtab('switchTab', 'main') })
                .find('> a').html(function(n, c) { return c.replace('#maintab#', BJUI.regional.maintab) })
            
            $mainLi
                .click(function() {
                    if ($(this).hasClass('active')) $moreBox.hide()
                    else $(this).navtab('switchTab', 'main')
                })
                .find('> a').html(function(n, c) { return c.replace('#maintab#', BJUI.regional.maintab) })
        }
        
        INIT_NAVTAB()
    })
    
    // NAVTAB CLASS DEFINITION
    // ======================
    
    var Navtab = function(element, options) {
        this.$element = $(element)
        this.options  = options
        this.tools    = this.TOOLS()
    }
    
    Navtab.DEFAULTS = {
        id          : undefined,
        title       : 'New tab',
        url         : undefined,
        type        : 'GET',
        data        : {},
        fresh       : false,
        onLoad      : null,
        beforeClose : null,
        onClose     : null
    }
    
    Navtab.prototype.TOOLS = function() {
        var that = this
        var tools = {
            getDefaults: function() {
                return Navtab.DEFAULTS
            },
            getTabs: function() {
                return $tabs.find('> li')
            },
            getPanels: function() {
                return $panels.find('> div')
            },
            getMoreLi: function() {
                return $moreBox.find('> li')
            },
            getTab: function(tabid) {
                var index = this.indexTabId(tabid)
                
                if (index >= 0) return this.getTabs().eq(index)
            },
            getPanel: function(tabid) {
                var index = this.indexTabId(tabid)
                
                if (index >= 0) return this.getPanels().eq(index)
            },
            getTabsW: function(iStart, iEnd) {
                return this.tabsW(this.getTabs().slice(iStart, iEnd))
            },
            tabsW: function($tabs) {
                var iW = 0
                $tabs.each(function() {
                    iW += $(this).outerWidth(true)
                })
                
                return iW
            },
            indexTabId: function(tabid) {
                if (!tabid) return -1
                if (tabid == 'main') return 0
                var iOpenIndex = -1
                
                this.getTabs().each(function(index) {
                    if ($(this).data('options') && $(this).data('options').id == tabid) {
                        iOpenIndex = index
                        return
                    }
                })
                return iOpenIndex
            },
            getLeft: function() {
                return $tabs.position().left
            },
            getScrollBarW: function() {
                return $box.width() - 55
            },
            visibleStart: function() {
                var iLeft = this.getLeft(), iW = 0
                var $tabs = this.getTabs()
                
                for (var i = 0; i < $tabs.size(); i++) {
                    if (iW + iLeft >= 0) return i
                    iW += $tabs.eq(i).outerWidth(true)
                }
                
                return 0
            },
            visibleEnd: function() {
                var iLeft = this.getLeft(), iW = 0
                var $tabs = this.getTabs()
                
                for (var i = 0; i < $tabs.size(); i++) {
                    iW += $tabs.eq(i).outerWidth(true)
                    if (iW + iLeft > this.getScrollBarW()) return i
                }
                
                return $tabs.size()
            },
            scrollPrev: function() {
                var iStart = this.visibleStart()
                
                if (iStart > 0)
                    this.scrollTab(-this.getTabsW(0, iStart - 1))
            },
            scrollNext: function() {
                var iEnd = this.visibleEnd()
                
                if (iEnd < this.getTabs().size())
                    this.scrollTab(-this.getTabsW(0, iEnd + 1) + this.getScrollBarW())
            },
            scrollTab: function(iLeft, isNext) {
                $tabs.animate({ left: iLeft }, 200, function() { that.tools.ctrlScrollBtn() })
            },
            scrollCurrent: function() { // auto scroll current tab
                var iW = this.tabsW(this.getTabs())
                
                if (iW <= this.getScrollBarW())
                    this.scrollTab(0)
                else if (this.getLeft() < this.getScrollBarW() - iW)
                    this.scrollTab(this.getScrollBarW()-iW)
                else if (currentIndex < this.visibleStart())
                    this.scrollTab(-this.getTabsW(0, currentIndex))
                else if (currentIndex >= this.visibleEnd())
                    this.scrollTab(this.getScrollBarW() - this.getTabs().eq(currentIndex).outerWidth(true) - this.getTabsW(0, currentIndex))
            },
            ctrlScrollBtn: function() {
                var iW = this.tabsW(this.getTabs())
                
                if (this.getScrollBarW() > iW) {
                    $prevBtn.hide()
                    $nextBtn.hide()
                    $tabs.parent().removeClass('tabsPageHeaderMargin')
                } else {
                    $prevBtn.show().removeClass('tabsLeftDisabled')
                    $nextBtn.show().removeClass('tabsRightDisabled')
                    $tabs.parent().addClass('tabsPageHeaderMargin')
                    if (this.getLeft() >= 0)
                        $prevBtn.addClass('tabsLeftDisabled')
                    else if (this.getLeft() <= this.getScrollBarW() - iW)
                        $nextBtn.addClass('tabsRightDisabled')
                }
            },
            switchTab: function(iTabIndex) {
                var $tab = this.getTabs().removeClass('active').eq(iTabIndex).addClass('active'), $panels = this.getPanels(), $panel = $panels.eq(iTabIndex)
                
                if ($tab.data('reloadFlag')) {
                    $panels.hide()
                    $panel.removeClass('fade').show()
                    that.refresh($tab.data('options').id)
                } else {
                    if (BJUI.ui.hideMode == 'offsets') {
                        $panels.css({position: 'absolute', top:'-100000px', left:'-100000px'}).eq(iTabIndex).css({position: '', top:'', left:''})
                    } else {
                        $panels.addClass('fade').removeClass('in').hide()
                        $panel.show()
                        
                        if ($.support.transition)
                            $panel.one('bsTransitionEnd', function() { $panel.addClass('in') }).emulateTransitionEnd(100)
                        else
                            $panels.removeClass('fade')
                            
                        setTimeout(function() {
                            if (!$panel.hasClass('in')) $panel.addClass('in')
                        }, 110)
                    }
                }
                
                $panel.find('.bjui-layout [data-layout-h]').layoutH()
                
                this.getMoreLi().removeClass('active').eq(iTabIndex).addClass('active')
                currentIndex = iTabIndex
                this.scrollCurrent()
                $currentTab     = $tab
                $.CurrentNavtab = $currentPanel = $panel
            },
            closeTab: function(index, openTabid) {
                var $tab        = this.getTabs().eq(index)
                var $more       = this.getMoreLi().eq(index)
                var $panel      = this.getPanels().eq(index)
                var options     = $tab.data('options')
                var beforeClose = options.beforeClose ? options.beforeClose.toFunc() : null
                var onClose     = options.onClose ? options.onClose.toFunc() : null
                var canClose    = true
                
                if (beforeClose) canClose = beforeClose.apply(that, [$panel])
                if (!canClose) {
                    that.tools.switchTab(index)
                    return
                }
                $tab.remove()
                $more.remove()
                $panel.trigger(BJUI.eventType.beforeCloseNavtab).remove()
                
                if (onClose) onClose.apply(that)
                if (currentIndex >= index) currentIndex--
                if (openTabid) {
                    var openIndex = this.indexTabId(openTabid)
                    
                    if (openIndex > 0) currentIndex = openIndex
                }
                
                this.scrollCurrent()
                this.switchTab(currentIndex)
            },
            closeOtherTab: function(index) {
                index = index || currentIndex
                
                this.getTabs().each(function(i) {
                    if (i > 0 && index != i) $(this).find('> .close').trigger('click')
                })
            },
            loadUrlCallback: function($panel) {
                $panel.find(':button.btn-close').click(function() { that.closeCurrentTab() })
            },
            reload: function($tab, flag) {
                flag    = flag || $tab.data('reloadFlag')
                
                var options = $tab.data('options')
                
                if (flag) {
                    $tab.data('reloadFlag', false)
                    var $panel = that.tools.getPanel(options.id)
                    
                    if ($tab.hasClass('external')) {
                        that.openExternal(options.url, $panel)
                    } else {
                        that.tools.reloadTab($panel, options)
                    }
                }
            },
            reloadTab: function($panel, options) {
                var onLoad = options.onLoad ? options.onLoad.toFunc() : null
                
                $panel
                    .trigger(BJUI.eventType.beforeLoadNavtab)
                    .ajaxUrl({
                        type:(options.type || 'GET'), url:options.url, data:options.data || {}, callback:function(response) {
                            that.tools.loadUrlCallback($panel)
                            if (onLoad) onLoad.apply(that, [$panel])
                            if (BJUI.ui.clientPaging && $panel.data('bjui.clientPaging')) $panel.pagination('setPagingAndOrderby', $panel)
                        }
                    })
            }
        }
        
        return tools
    }
    
    Navtab.prototype.contextmenu = function($obj) {
        var that = this
        $obj.contextmenu({
            id: 'navtabCM',
            bindings: {
                reload: function(t, m) {
                    if (!t.data('tabid')) that.refresh(t.data('initOptions').id)
                },
                closeCurrent: function(t, m) {
                    if (!t.data('tabid')) {
                        var tabId = t.data('options').id
                        
                        if (tabId) that.closeTab(tabId)
                        else that.closeCurrentTab()
                    }
                },
                closeOther: function(t, m) {
                    if (t.data('tabid') == 'main') {
                        that.closeAllTab()
                    } else {
                        var index = that.tools.indexTabId(t.data('options').id)
                        
                        that.tools.closeOtherTab(index > 0 ? index : currentIndex)
                    }
                },
                closeAll: function(t, m) {
                    that.closeAllTab()
                }
            },
            ctrSub: function(t, m) {
                var mReload = m.find('[rel="reload"]')
                var mCur    = m.find('[rel="closeCurrent"]')
                var mOther  = m.find('[rel="closeOther"]')
                var mAll    = m.find('[rel="closeAll"]')
                var $tabLi  = that.tools.getTabs()
                
                if (t.data('tabid') == 'main') {
                    mCur.addClass('disabled')
                    mReload.addClass('disabled')
                }
            }
        })
    }
    
    // if found tabid replace tab, else create a new tab.
    Navtab.prototype.openTab = function() {
        var that = this, $element = this.$element, options = this.options, tools = this.tools
        
        if (!(options.url)) {
            BJUI.debug('Navtab Plugin: Error trying to open a navtab, url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($element.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                $element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
                BJUI.debug('Navtab Plugin: The new navtab\'s url is incorrect, url: '+ options.url)
                return
            }
            
            options.url = encodeURI(options.url)
        }
        if (!options.id) {
            BJUI.debug('Navtab Plugin: Error trying to open a navtab, the id is undefined!')
            return
        }
        
        var iOpenIndex = tools.indexTabId(this.options.id)
        
        if (iOpenIndex >= 0) {
            var $tab   = tools.getTabs().eq(iOpenIndex)
            var $panel = tools.getPanels().eq(iOpenIndex)
            var op     = $tab.data('initOptions') || options
            
            if (op.fresh || options.fresh || op.url != options.url) {
                that.reload(options)
                $tab.data('initOptions', options)
            }
            
            currentIndex = iOpenIndex
        } else {
            var tabFrag = '<li><a href="javascript:" title="#title#"><span>#title#</span></a><span class="close">&times;</span></li>'
            var $tab = $(tabFrag.replaceAll('#title#', options.title))
            var $panel = $('<div class="page unitBox"></div>')
            var $more  = $('<li><a href="javascript:" title="#title#">#title#</a></li>'.replaceAll('#title#', options.title))
            
            $tab.appendTo($tabs)
            $panel.appendTo($panels)
            $more.appendTo($moreBox)
             
            if (options.external || (options.url && options.url.isExternalUrl())) {
                $tab.addClass('external')
                this.openExternal(options.url, $panel)
            } else {
                $tab.removeClass('external')
                tools.reloadTab($panel, options)
            }
            
            currentIndex = tools.getTabs().length - 1
            this.contextmenu($tab)
            
            //events
            $tab.on('click', function(e) {
                var $target = $(e.target)
                
                if ($target.hasClass('close'))
                    that.closeTab(options.id)
                else if ($target.closest('li').hasClass('active'))
                    return false
                else
                    that.switchTab(options.id)
            })
            $more.on('click', function() {
                that.switchTab(options.id)
            })
            $tab.data('options', options)
                .data('initOptions', options)
        }
        
        tools.switchTab(currentIndex)
        tools.scrollCurrent()
    }
    
    Navtab.prototype.closeTab = function(tabid) {
        var index = this.tools.indexTabId(tabid)
        
        if (index > 0)
            this.tools.closeTab(index)
    }
    
    Navtab.prototype.closeCurrentTab = function(openTabid) { //openTabid can be empty. close current tab by default, and open the last tab
        if (currentIndex > 0)
            this.tools.closeTab(currentIndex, openTabid)
    }
    
    Navtab.prototype.closeAllTab = function() {
        this.tools.getTabs().find('> .close').each(function() {
            $(this).trigger('click')
        })
    }
    
    Navtab.prototype.reloadFlag = function(tabids) {
        var arr = tabids.split(',')
        
        for (var i = 0; i < arr.length; i++) {
            var $tab = this.tools.getTab(arr[i].trim())
            
            if ($tab) {
                if (this.tools.indexTabId(arr[i]) == currentIndex) this.tools.reload($tab, true)
                else $tab.data('reloadFlag', true)
            }
        }
    }
    
    Navtab.prototype.switchTab = function(tabid) {
        var index = this.tools.indexTabId(tabid)
        
        this.tools.switchTab(index)
    }
    
    Navtab.prototype.scrollPrev = function() {
        this.tools.scrollPrev()
    }
    
    Navtab.prototype.scrollNext = function() {
        this.tools.scrollNext()
    }
    
    Navtab.prototype.refresh = function(tabid) {
        var $tab = tabid ? this.tools.getTab(tabid) : $currentTab, $panel
        
        if ($tab) {
            $panel = this.tools.getPanel($tab.data('initOptions').id)
            $panel.removeData('bjui.clientPaging')
            
            this.reload($tab.data('initOptions'))
        }
    }
    
    Navtab.prototype.reload = function(option) {
        var that    = this
        var options = $.extend({}, typeof option == 'object' && option)
        var $tab    = options.id ? this.tools.getTab(options.id) : this.tools.getTabs().eq(currentIndex)
        
        if ($tab) {
            var op = $tab.data('initOptions') || options
            var _reload = function() {
                if (options.title != op.title) $tab.find('> a').attr('title', options.title).find('> span').html(options.title)
                
                $tab.data('options', $.extend({}, op, options))
                that.tools.reload($tab, true)
            }
            
            if (options.reloadWarn) {
                this.$element.alertmsg('confirm', options.reloadWarn, {
                    okCall: function() {
                        _reload()
                    }
                })
            } else {
                _reload()
            }
        }
    }
    
    Navtab.prototype.reloadForm = function(clearQuery, option) {
        var options = $.extend({}, typeof option == 'object' && option)
        var $tab, $panel
        
        if (typeof option == 'string') {
            $tab   = this.tools.getTab(option)
            $panel = this.tools.getPanel(option)
        } else {
            $tab   = options.id ? this.tools.getTab(options.id) : this.tools.getTabs().eq(currentIndex)
            $panel = options.id ? this.tools.getPanel(options.id) : this.tools.getPanels().eq(currentIndex)
        }
        if ($tab && $panel) {
            if (!$tab.hasClass('external')) {
                var $pagerForm = $panel.find('#pagerForm'), data = {}, pageData = {}
                
                if ($pagerForm && $pagerForm.length) {
                    pageData = $pagerForm.serializeJson()
                    if (!option || !option.type) options.type = $pagerForm.attr('method') || 'POST'
                    if (clearQuery) {
                        var pageInfo = BJUI.pageInfo
                        
                        for (var key in pageInfo) {
                            data[pageInfo[key]] = pageData[pageInfo[key]]
                        }
                    } else {
                        data = pageData
                    }
                    options.data = $.extend({}, options.data || {}, data)
                }
            }
            this.reload(options)
        }
    }
    
    Navtab.prototype.getCurrentPanel = function() {
        return this.tools.getPanels().eq(currentIndex)
    }
    
    Navtab.prototype.checkTimeout = function() {
        var json = JSON.parse($currentPanel.html())
        
        if (json && json[BJUI.keys.statusCode] == BJUI.statusCode.timeout) this.closeCurrentTab()
    }
    
    Navtab.prototype.openExternal = function(url, $panel) {
        var ih = $panel.closest('.navtab-panel').height()
        
        $panel.html(FRAG.externalFrag.replaceAll('{url}', url).replaceAll('{height}', ih +'px'))
    }
    
    // NAVTAB PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Navtab.DEFAULTS, $this.data(), typeof option == 'object' && option)
            var data    = $this.data('bjui.navtab')
            
            if (!data) $this.data('bjui.navtab', (data = new Navtab(this, options)))
            else if (data.options.id && data.options.id != options.id) $this.data('bjui.navtab', (data = new Navtab(this, options)))
            
            if (typeof property == 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.openTab()
            }
        })
    }

    var old = $.fn.navtab

    $.fn.navtab             = Plugin
    $.fn.navtab.Constructor = Navtab
    
    // NAVTAB NO CONFLICT
    // =================
    
    $.fn.navtab.noConflict = function () {
        $.fn.navtab = old
        return this
    }
    
    // NAVTAB DATA-API
    // ==============

    $(document).on('click.bjui.navtab.data-api', '[data-toggle="navtab"]', function(e) {
        var $this   = $(this)
        var options = $this.data()
        
        if (!options.url)   options.url   = $this.attr('href')
        if (!options.title) options.title = $this.text()
        
        Plugin.call($this, options)
        
        e.preventDefault()
    })
    
}(jQuery);