(function(){
  'use strict';

  document.documentElement.classList.add('js');

  /* ============================================
     Scroll Reveal Animations
  ============================================ */
  function initScrollReveal() {
    var revealEls = document.querySelectorAll('.reveal, .reveal-left, .reveal-right, .reveal-scale');
    if (revealEls.length) {
      var observer = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add('revealed');
            observer.unobserve(entry.target);
          }
        });
      }, {
        threshold: 0.1,
        rootMargin: '0px 0px -60px 0px'
      });

      revealEls.forEach(function(el) {
        observer.observe(el);
      });
    }

    // Staggered reveal for grid items
    var gridContainers = document.querySelectorAll('.services-grid, .solutions-grid, .tech-grid, .trust-grid, .process-grid, .industries-grid');
    gridContainers.forEach(function(grid) {
      var items = grid.querySelectorAll('.service-card, .solution-card, .tech-item, .trust-item, .process-step, .industry-card');
      if (!items.length) return;

      var gridObserver = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
          if (entry.isIntersecting) {
            var gridItems = entry.target.querySelectorAll('.service-card, .solution-card, .tech-item, .trust-item, .process-step, .industry-card');
            gridItems.forEach(function(item, index) {
              setTimeout(function() {
                item.classList.add('revealed');
              }, index * 100);
            });
            gridObserver.unobserve(entry.target);
          }
        });
      }, { threshold: 0.15 });

      gridObserver.observe(grid);
    });
  }

  /* ============================================
     Back to Top Button
  ============================================ */
  function initBackToTop() {
    var btn = document.querySelector('.back-to-top');
    if (!btn) {
      btn = document.createElement('button');
      btn.className = 'back-to-top';
      btn.setAttribute('aria-label', 'Back to top');
      btn.innerHTML = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"/></svg>';
      document.body.appendChild(btn);
    }

    var scrollThreshold = 400;
    var ticking = false;

    function onScroll() {
      if (!ticking) {
        window.requestAnimationFrame(function() {
          if (window.scrollY > scrollThreshold) {
            btn.classList.add('visible');
          } else {
            btn.classList.remove('visible');
          }
          ticking = false;
        });
        ticking = true;
      }
    }

    window.addEventListener('scroll', onScroll, { passive: true });

    btn.addEventListener('click', function() {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  /* ============================================
     Lazy Image Load Handler
  ============================================ */
  function initLazyImages() {
    var imgs = document.querySelectorAll('img[loading="lazy"]');
    imgs.forEach(function(img) {
      if (img.complete) {
        img.classList.add('loaded');
      } else {
        img.addEventListener('load', function() {
          img.classList.add('loaded');
        });
        img.addEventListener('error', function() {
          img.classList.add('loaded');
        });
      }
    });
  }

  /* ============================================
     Counter Animation
  ============================================ */
  function animateCounter(el) {
    var text = el.textContent.trim();
    var numStr = text.replace(/[^0-9.]/g, '');
    var suffix = text.replace(/[0-9.]/g, '');
    var target = parseFloat(numStr, 10);
    if (isNaN(target) || target === 0) return;

    var duration = 2000;
    var startTime = null;
    var isDecimal = numStr.indexOf('.') > -1;

    function animate(timestamp) {
      if (!startTime) startTime = timestamp;
      var progress = Math.min((timestamp - startTime) / duration, 1);
      var eased = 1 - Math.pow(1 - progress, 3);
      var current = eased * target;
      if (isDecimal) {
        el.textContent = current.toFixed(1) + suffix;
      } else {
        el.textContent = Math.floor(current) + suffix;
      }
      if (progress < 1) {
        window.requestAnimationFrame(animate);
      } else {
        el.textContent = target + suffix;
      }
    }
    window.requestAnimationFrame(animate);
  }

  function initCounters() {
    var counters = document.querySelectorAll('.hero-stat h3, .metric-number');
    if (!counters.length) return;

    var observer = new IntersectionObserver(function(entries) {
      entries.forEach(function(entry) {
        if (entry.isIntersecting) {
          animateCounter(entry.target);
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.3 });

    counters.forEach(function(el) {
      observer.observe(el);
    });
  }

  /* ============================================
     Smooth Anchor Scrolling
  ============================================ */
  function initSmoothAnchors() {
    document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
      anchor.addEventListener('click', function(e) {
        var href = this.getAttribute('href');
        if (href === '#') return;
        var target = document.querySelector(href);
        if (target) {
          e.preventDefault();
          var navHeight = 80;
          var targetPos = target.getBoundingClientRect().top + window.pageYOffset - navHeight;
          window.scrollTo({ top: targetPos, behavior: 'smooth' });
        }
      });
    });
  }

  /* ============================================
     Nav Dropdown Touch Support
     (Mobile menu toggle is handled by each page's
     inline script — do not bind it here too, or
     each tap toggles the menu twice.)
  ============================================ */
  function initDropdownTouch() {
    if (!('ontouchstart' in window)) return;
    document.querySelectorAll('.nav-links > li > a[aria-haspopup]').forEach(function(trigger) {
      trigger.addEventListener('click', function(e) {
        var li = this.parentElement;
        var dropdown = li.querySelector('.dropdown, .nav-dropdown');
        if (!dropdown) return;
        var isOpen = dropdown.style.display === 'block';
        // Close all first
        document.querySelectorAll('.dropdown, .nav-dropdown').forEach(function(d) {
          d.style.display = '';
        });
        if (!isOpen) {
          e.preventDefault();
          dropdown.style.display = 'block';
        }
      });
    });

    // Close dropdowns when tapping outside
    document.addEventListener('click', function(e) {
      if (!e.target.closest('.nav-links > li')) {
        document.querySelectorAll('.dropdown, .nav-dropdown').forEach(function(d) {
          d.style.display = '';
        });
      }
    });
  }

  /* ============================================
     Parallax Hero Glow Effect
  ============================================ */
  function initHeroParallax() {
    var hero = document.querySelector('.hero, .blog-hero, .post-hero');
    if (!hero) return;

    hero.addEventListener('mousemove', function(e) {
      var rect = hero.getBoundingClientRect();
      var x = (e.clientX - rect.left) / rect.width - 0.5;
      var y = (e.clientY - rect.top) / rect.height - 0.5;
      var glows = hero.querySelectorAll('::before, ::after');
      // Subtle CSS custom prop approach instead
      hero.style.setProperty('--mouse-x', (x * 20) + 'px');
      hero.style.setProperty('--mouse-y', (y * 20) + 'px');
    });
  }

  /* ============================================
     Navbar Background on Scroll
  ============================================ */
  function initNavScroll() {
    var nav = document.querySelector('nav');
    if (!nav) return;
    var tickingNav = false;

    function updateNav() {
      if (window.scrollY > 10) {
        nav.style.background = 'rgba(255,255,255,0.98)';
        nav.style.boxShadow = '0 1px 3px rgba(0,0,0,0.06)';
      } else {
        nav.style.background = 'rgba(255,255,255,0.97)';
        nav.style.boxShadow = 'none';
      }
    }

    window.addEventListener('scroll', function() {
      if (!tickingNav) {
        window.requestAnimationFrame(function() {
          updateNav();
          tickingNav = false;
        });
        tickingNav = true;
      }
    }, { passive: true });

    updateNav();
  }

  /* ============================================
     Floating Book a Meeting Button
  ============================================ */
  function initFloatingMeetingBtn() {
    if (document.querySelector('.floating-meeting-btn')) return;
    if (window.location.pathname === '/book-meeting/' || window.location.pathname === '/careers/apply/') return;
    
    var btn = document.createElement('a');
    btn.href = '/book-meeting/';
    btn.className = 'floating-meeting-btn';
    btn.setAttribute('aria-label', 'Book a Meeting');
    btn.innerHTML = '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg><span>Book a Meeting</span>';
    document.body.appendChild(btn);
  }

  /* ============================================
     Initialize Everything
  ============================================ */
  function init() {
    initScrollReveal();
    initBackToTop();
    initLazyImages();
    initCounters();
    initSmoothAnchors();
    initDropdownTouch();
    initHeroParallax();
    initNavScroll();
    initFloatingMeetingBtn();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
